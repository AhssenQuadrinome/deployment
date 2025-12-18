output "vpc_id" {
	description = "VPC ID"
	value       = aws_vpc.main.id
}

output "public_subnet_id" {
	description = "Public subnet ID"
	value       = aws_subnet.public.id
}

output "internet_gateway_id" {
	description = "Internet Gateway ID"
	value       = aws_internet_gateway.igw.id
}

output "public_route_table_id" {
	description = "Public route table ID"
	value       = aws_route_table.public.id
}

output "alb_security_group_id" {
	description = "ALB security group ID"
	value       = aws_security_group.alb.id
}

output "ec2_security_group_id" {
  description = "EC2 security group ID"
  value       = aws_security_group.ec2.id
}

output "ec2_public_ip" {
  description = "Public IP address of the EC2 instance (SSH)"
  value       = aws_instance.app.public_ip
}

output "alb_dns_name" {
  description = "Public DNS name of the Application Load Balancer"
  value       = aws_lb.app.dns_name
}
