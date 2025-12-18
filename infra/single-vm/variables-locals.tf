#############################################
# Variables
#############################################

variable "availability_zone" {
  description = "Availability zone for the single VM"
  default     = "us-east-1a"
}

variable "availability_zone_2" {
  description = "Second availability zone for ALB"
  default     = "us-east-1b"
}

variable "instance_type" {
  description = "EC2 instance type for the application VM"
  default     = "t3.medium"
}

variable "key_name" {
  description = "SSH key pair name for EC2 access"
  type        = string
}

variable "my_ip_cidr" {
  description = "Your public IP in CIDR notation for SSH access (e.g. 1.2.3.4/32)"
  type        = string
}


#############################################
# Locals
#############################################

locals {
  name_prefix = "ourbusway"
}

locals {
  common_tags = {
    Project = "OurBusWay"
    Owner   = "abderrahmane "
  }
}

locals {
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
  public_subnet_cidr_2 = "10.0.2.0/24"
}
