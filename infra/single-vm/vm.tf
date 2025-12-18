# EC2 Instance (Single VM)

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

resource "aws_instance" "app" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.ec2.id]
  key_name               = var.key_name

  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              set -e

              yum update -y

              # Install Docker
              yum install -y docker

              # Enable and start Docker
              systemctl enable docker
              systemctl start docker

              # Allow ec2-user to run Docker without sudo
              usermod -aG docker ec2-user

              # Install Docker Compose plugin
              mkdir -p /usr/local/lib/docker/cli-plugins
              curl -SL https://github.com/docker/compose/releases/download/v2.25.0/docker-compose-linux-x86_64 \
                -o /usr/local/lib/docker/cli-plugins/docker-compose
              chmod +x /usr/local/lib/docker/cli-plugins/docker-compose
              EOF


  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-vm"
  })
}
