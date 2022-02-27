//
// SECTION FOR EC2
//
resource "aws_instance" "crypto_ec2" {
  associate_public_ip_address = true

  ami                    = var.ec2_ami
  instance_type          = var.ec2_type
  key_name               = var.key_name
  subnet_id              = var.ec2_subnet_id
  vpc_security_group_ids = [var.sg_pub_id]
  iam_instance_profile   = var.ec2_profile_name

  tags = {
    Name = "${var.namespace}-ec2-public"
  }

  connection {
    type = "ssh"
    user = "root"
    private_key = "${file("${var.private_key_path}")}"
  }
  
  provisioner "file" {
    source = "C:/Users/Johnny/AppData/Local/Jenkins/.jenkins/workspace/crypto/CryptoApp.zip"
    destination = "./"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Hello World'"
    ]
  }
}