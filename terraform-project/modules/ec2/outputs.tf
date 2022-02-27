output "public_ip" {
  value = aws_instance.crypto_ec2.public_ip
}

output "public_dns" {
  value = aws_instance.crypto_ec2.public_dns
}


//
// SECTION FOR EIP
//
# output "eip_public_ip" {
#   value = aws_eip.crypto_ec2_eip.public_ip
#   depends_on = [aws_eip.crypto_ec2_eip]
# }

# output "eip_public_ip" {
#   value = aws_eip.crypto_ec2_eip.public_dns
#   depends_on = [aws_eip.crypto_ec2_eip]
# }

