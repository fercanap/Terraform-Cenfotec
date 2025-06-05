<<<<<<< HEAD
resource "aws_launch_template" "app" {
  name_prefix   = "lt-${var.lab_name}-"
  image_id      = var.ami_id
  instance_type = "t3.micro"
  key_name      = var.key_name

  vpc_security_group_ids = [var.asg_sg_id]

  user_data = base64encode(<<EOF
#!/bin/bash
apt update -y
apt install -y nginx
echo "<h1>Hola desde autoscaling group - ${var.lab_name}</h1>" > /var/www/html/index.html
systemctl start nginx
systemctl enable nginx
EOF
  )
=======
resource "aws_launch_template" "launch_webserver" {
  name_prefix   = "${var.lab_name}-launchcfg-"
  image_id      = var.ubuntu_ami.id
  instance_type = "t3a.nano"
  key_name      = var.ssh_key.key_name

  instance_market_options {
    market_type = "spot"
    spot_options {
      max_price = "0.016"
    }
  }

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [var.sg_private.id]
  }

  user_data = base64encode(templatefile("${path.module}/../config/app.sh", {}))
>>>>>>> b07d844a (Reinicializa y agrega los archivos del lab final)

  lifecycle {
    create_before_destroy = true
  }
}

<<<<<<< HEAD
resource "aws_autoscaling_group" "app_asg" {
  name                      = "asg-${var.lab_name}"
  max_size                  = 2
  min_size                  = 1
  desired_capacity          = 1
  vpc_zone_identifier       = var.subnet_ids
  health_check_type         = "EC2"
  health_check_grace_period = 30

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }

  target_group_arns = [var.target_group_arn]

  tag {
    key                 = "Name"
    value               = "app-${var.lab_name}"
=======
resource "aws_autoscaling_group" "asg_webserver" {
  name                      = "asg-${var.lab_name}"
  vpc_zone_identifier       = [var.private_subnet.id]
  launch_template {
  id      = aws_launch_template.launch_webserver.id
  version = "$Latest"
  }
  desired_capacity          = 1
  min_size                  = 1
  max_size                  = 2
  health_check_grace_period = 300
  target_group_arns         = [var.tgWebserver_arn]
  termination_policies      = ["NewestInstance"]
  suspended_processes       = ["Terminate"]

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "ASG-${var.lab_name}"
>>>>>>> b07d844a (Reinicializa y agrega los archivos del lab final)
    propagate_at_launch = true
  }
}
