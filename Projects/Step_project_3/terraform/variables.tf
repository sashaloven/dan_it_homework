variable "tags" {
    type = map
    default = {
        Name = "Lovyniuk"
    }
}

variable "ami" {
  description = "The AMI ID to use for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The type of instance to use"
  type        = string
}