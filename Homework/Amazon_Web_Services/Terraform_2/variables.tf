variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "list_of_open_ports" {
  description = "List of ports to allow"
  type        = list(number)
}

variable "subnet_id" {
  description = "The ID of the public subnet in the VPC"
  type        = string
}