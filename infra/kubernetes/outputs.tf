output "vpc_id" {
	description = "VPC ID"
	value       = aws_vpc.main.id
}

output "public_subnet_id" {
	description = "Public subnet ID"
	value       = aws_subnet.public.id
}

output "private_subnet_id" {
	description = "Private subnet ID"
	value       = aws_subnet.private.id
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

output "db_security_group_id" {
	description = "DB security group ID"
	value       = aws_security_group.db.id
}

output "db_subnet_group_name" {
	description = "RDS subnet group name"
	value       = aws_db_subnet_group.app.name
}

output "rds_instance_identifier" {
	description = "RDS instance identifier"
	value       = aws_db_instance.app.id
}

output "rds_endpoint" {
	description = "RDS endpoint hostname"
	value       = aws_db_instance.app.address
}

output "rds_kms_key_arn" {
	description = "KMS key ARN used for RDS encryption"
	value       = aws_kms_key.rds.arn
}
