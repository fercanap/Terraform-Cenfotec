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

  lifecycle {
    create_before_destroy = true
  }
}

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
    propagate_at_launch = true
  }
}
