data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_launch_template" "template" {

  name_prefix   = "${var.project_name}-template"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.aws_instance

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

 lifecycle {
  ignore_changes = [user_data]
  }

  user_data = base64encode(<<EOF
#!/bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
echo "Hello from Auto Scaling Group $(hostname)" > /var/www/html/index.html
EOF
  )
}

