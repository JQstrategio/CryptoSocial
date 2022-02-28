variable "namespace" {
  type = string
}

variable "ec2_subnet_id" {
  type = string
}

variable "sg_pub_id" {
  type = any
}

variable "key_name" {
  type = string
}

variable "ec2_profile_name" {
  type = string
}


//
// SECTION FOR EC2
//

variable "ec2_ami" {
  description = "EC2 ami id"
  type        = string
  default     = "ami-04505e74c0741db8d"
}

variable "ec2_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "private_key_path" {
  description = "path to private key for ec2"
  type        = string
  default     = "C:/Users/Johnny/CryptoSocial/terraform-project/Crypto-key.pem"
}