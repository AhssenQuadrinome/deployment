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
    tags = merge(local.common_tags, { Name = "${local.name_prefix}-alb-sg" })
}

resource "aws_security_group" "db" {
    name = "${local.name_prefix}-db-sg"
    vpc_id = aws_vpc.main.id

    #from app 
    #i will need to allow traffic from the eks cluster to port 5432 (psql default)
    # i need to create that sg once i understand how it works 

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = merge(local.common_tags, { Name = "${local.name_prefix}-db-sg" })

}