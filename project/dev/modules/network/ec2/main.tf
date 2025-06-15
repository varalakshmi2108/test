resource "aws_security_group" "ec2_sg" {
  name   = "ec2-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [var.alb_sg_id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  count         = var.ec2_count
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_ids[count.index]
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              yum install -y httpd
              systemctl start httpd
              echo "Hello from Instance ${count.index + 1}" > /var/www/html/index.html
              EOF

  tags = {
    Name = "web-${count.index + 1}"
  }
}

resource "aws_lb_target_group_attachment" "attachment" {
  count            = var.ec2_count
  target_group_arn = var.target_group_arn
  target_id        = aws_instance.web[count.index].id
  port             = 80
}
