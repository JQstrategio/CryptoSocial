variable "namespace" {
  type = string
}

variable "policy_arns" {
  description = "List of ARNs of IAM policies to attach to IAM Role"
  type        = list(string)
  default     = ["arn:aws:iam::aws:policy/AmazonS3FullAccess"]
}
