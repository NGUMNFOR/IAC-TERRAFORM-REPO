
/*variable ami_id {
    type = string
    default = "ami-0022f774911c1d690"
    description = "ec2 ami id"
}
*/

variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "This is for my instance type"
}

variable "myregion" {
  type        = string
  default     = "us-east-1"
  description = "This is for my region"
}

variable "create_instance" {
  type = bool
  default = true
  description = " create instance"
}