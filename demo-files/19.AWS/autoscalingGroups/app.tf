resource "aws_launch_configuration" "launch_webserver" {
  image_id                    = var.ubuntu_ami.id
  name_prefix                 = var.lab_name
  instance_type               = "t3a.nano"
  spot_price                  = "0.016"
  associate_public_ip_address = false # false = no asigna ip publica
  security_groups             = [var.sgPrivate.id]
  key_name                    = var.ssh_key.key_name

  user_data = templatefile("./config/app.sh", {})

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_policy" "target_tracking_webserver" {
  name                   = "CPU_Utilization"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.asg_webserver.name
  # scaling_adjustment     = 1
  # adjustment_type        = "ChangeInCapacity"
  # cooldown               = 300
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 80.0
  }
}

resource "aws_autoscaling_group" "asg_webserver" {
  name                      = "asg-${var.lab_name}"
  vpc_zone_identifier       = [var.private_subnet.id]
  launch_configuration      = aws_launch_configuration.launch_webserver.name
  desired_capacity          = 1
  min_size                  = 1
  max_size                  = 2
  health_check_grace_period = 300
  # health_check_type         = "ELB"

  # LOAD BALANCING
  target_group_arns = [var.tgWebserver_arn]

  termination_policies = ["NewestInstance"]
  suspended_processes  = ["Terminate"]

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["tag"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "ASG-${var.lab_name}"
    propagate_at_launch = true
  }
}
