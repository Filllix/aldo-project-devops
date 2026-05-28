variable "ami" {}
variable "instance_type" {}
variable "key_name" {}
variable "subnet_id" {}
variable "vpc_id" {}
variable "env" {}
variable "instance_name" {}

variable "vpc_cidr" {
  description = "VPC CIDR used to restrict internal monitoring access."
  type        = string
}

variable "admin_cidr_blocks" {
  description = "CIDR blocks allowed to access SSH. Replace the default with your public IP for real deployments."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
