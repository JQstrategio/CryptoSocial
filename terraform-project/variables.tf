variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "namespace" {
  description = "Project namespace for unique resource naming"
  type        = string
  default     = "Crypto"
}


# variable "my_ip" {
#   description = "SG access IP address"
#   type        = string
#   sensitive   = true
# }
