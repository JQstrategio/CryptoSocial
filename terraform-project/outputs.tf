output "public_connection_string" {
  description = "ssh into ec2"
  value       = "ssh -i ${module.ssh-key.key_name}.pem ec2-user@${module.ec2.public_ip}"
}