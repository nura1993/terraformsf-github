variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}

variable "private_key" {
  description = "Private key content for SSH"
  type        = string
}

