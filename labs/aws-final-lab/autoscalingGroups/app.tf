############################################
# Launch Template
############################################
resource "aws_launch_template" "launch_webserver" {
  name_prefix   = "${var.lab_name}-lt-"
  image_id      = var.ubuntu_ami.id
  instance_type = "t3a.nano"
  key_name      = var.ssh_key.key_name

  ##########################################
  # Instancias SPOT – máx USD 0.016/h
  ##########################################
  instance_market_options {
    market_type = "spot"
    spot_options {
      max_price = "0.016"
    }
  }

  ##########################################
  # NIC + Security Group
  ##########################################
  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [var.sg_private.id]
  }

  ##########################################
  # User-data codificado en Base64
  ##########################################
  user_data = base64encode(
    templatefile("${path.module}/../config/app.sh", {})
  )

  lifecycle {
    create_before_destroy = true
  }
}

############################################
# Auto Scaling Group
############################################
resource "aws_autoscaling_group" "asg_webserver" {
  name                = "asg-${var.lab_name}"
  vpc_zone_identifier = [var.private_subnet.id]

  launch_template {
    id      = aws_launch_template.launch_webserver.id
    version = "$Latest"
  }

  desired_capacity          = 1
  min_size                  = 1
  max_size                  = 2
  health_check_grace_period = 300
  target_group_arns         = [var.tgWebserver_arn]

  termination_policies = ["NewestInstance"]
  suspended_processes  = ["Terminate"]

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "ASG-${var.lab_name}"
    propagate_at_launch = true
  }
}
