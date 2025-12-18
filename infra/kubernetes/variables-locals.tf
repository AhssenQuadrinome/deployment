variable "availability_zone" {
    description = "availability zone , one for the current deployment"
    default = "us-east-1a"
}

variable "availability_zone_2" {
  description = "second availability zone for subnet group coverage"
  default     = "us-east-1b"
}

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

  vpc_cidr = "10.0.0.0/16"

  public_subnet_cidr = "10.0.1.0/24"

  private_subnet_cidr = "10.0.3.0/24"
}

locals {
  private_subnet_cidr_2 = "10.0.4.0/24"
}