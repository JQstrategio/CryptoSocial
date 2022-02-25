# Generate output of IAM role name
output "ec2_profile_name" {
  description = "IAM role instance profile name"
  value       = aws_iam_instance_profile.ec2_profile.name
}