variable "aws_region" {
  description = "AWS region to deploy"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "AWS CLI profile to use"
  type        = string
  default     = "default"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  type    = list(string)
  default = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "instance_type" {
  default = "t2.micro"
}

variable "asg_desired" {
  default = 2
}

variable "allowed_cidr" {
  description = "Allow access to ALB from this CIDR"
  default     = "0.0.0.0/0"
}
