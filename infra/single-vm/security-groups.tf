resource "aws_security_group" "alb"{
    name = "${local.name_prefix}-alb-sg"
    vpc_id = aws_vpc.main.id

    # only http since https requires a domain in aws 
    ingress {
        description = "http from everywhere"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        description = "allow all outbound traffic "
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = merge(local.common_tags, { 
        Name = "${local.name_prefix}-alb-sg"
    })
}

resource "aws_security_group" "ec2" {
  name   = "${local.name_prefix}-ec2-sg"
  vpc_id = aws_vpc.main.id

  # SSH access (ONLY from your IP)
  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Application traffic from ALB only
  ingress {
    description     = "App traffic from ALB"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-ec2-sg"
  })
}