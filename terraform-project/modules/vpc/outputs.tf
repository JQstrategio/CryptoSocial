# output "vpc" {
#   value = module.vpc
# }

output "ec2_subnet_id" {
  value = aws_subnet.crypto_public_subnet.id
}

output "sg_pub_id" {
  value = aws_security_group.allow_ssh.id
}