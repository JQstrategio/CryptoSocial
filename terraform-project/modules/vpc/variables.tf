variable "namespace" {
  type = string
}

//
// SECTION FOR VPC
//
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}
variable "vpc_enable_DNS" {
  description = "Enable DNS Hostnames"
  type        = bool
  default     = true
}


//
// SECTION FOR PUBLIC SUBNETS
//
variable "public_subnet" {
  description = "Public subnets for VPC"
  type        = string
  default     = "10.0.101.0/24"
}

variable "subnet_az" {
  description = "Avalability zones for VPC"
  type        = string
  default     = "us-east-1a"
}