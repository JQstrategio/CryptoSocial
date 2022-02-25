//
// SECTION FOR EC2
//
module "crypto_ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = ">= 3.0"

  name                        = "${var.namespace}-ec2-public"
  associate_public_ip_address = true

  ami                    = var.ec2_ami
  instance_type          = var.ec2_type
  key_name               = var.key_name
  subnet_id              = var.ec2_subnet_id
  vpc_security_group_ids = [var.sg_pub_id]
  iam_instance_profile   = var.ec2_profile_name
}

//
// SECTION FOR IF EIP IS NEEDED
//
# resource "aws_eip" "crypto_ec2_eip" {
#   instance = module.crypto_ec2.id
#   vpc = true

#   tags = {
#     Name = "${var.namespace}-eip"
#   }
# }