# Generate assume role policy
data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# Configure IAM role
resource "aws_iam_role" "ec2_access_s3_role" {
  name                = "${var.namespace}-role"
  path                = "/"
  assume_role_policy  = data.aws_iam_policy_document.ec2_assume_role.json
  managed_policy_arns = var.policy_arns
}

# Configure IAM instance profile
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.namespace}-profile"
  role = aws_iam_role.ec2_access_s3_role.name
}
