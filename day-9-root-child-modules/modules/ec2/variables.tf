
variable "ami" {
  type        = string
  description = "AMI ID"
}

variable "instance_type" {
  type        = string
  description = "Instance type"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID"
}

variable "security_group_id" {
  type        = string
  description = "Security Group ID"
}

variable "instance_name" {
  type        = string
  description = "Name tag for the instance"
}

