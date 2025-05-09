variable "aws_region" {
  description = "AWS region"
  type = string
}

variable "ami_id" {
  description = "Ubuntu 20.04 AMI ID"
  type = string
}

variable "num_ec2" {
  description = "Number of EC2 instances"
  type = number
}

variable "type_ec2" {
  description = "EC2 instance type"
  type = string
}