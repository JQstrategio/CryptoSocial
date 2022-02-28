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
}

resource "null_resource" "config" {
  triggers = {
    always_run = "${timestamp()}"
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    host        = aws_instance.crypto_ec2.public_ip
    private_key = file("${var.private_key_path}")
  }

  //
  // Deploy
  //
  provisioner "file" {
    source      = "C:/Users/Johnny/AppData/Local/Jenkins/.jenkins/workspace/crypto/CryptoApp.zip"
    destination = "CryptoApp.zip"
  }

  //
  // Config
  //
  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt upgrade -y",
      "sudo apt install python pip unzip -y"
    ]
  }

  //
  // Unpack
  //
  provisioner "remote-exec" {
    inline = [
      "unzip -o CryptoApp.zip",
      "rm CryptoApp.zip"
    ]
  }

  //
  // Final config
  //
  provisioner "remote-exec" {
    inline = [
      "cd CryptoSocial/app",
      "sudo pip install -r requirements.txt",
      "sed -i \"s/127.0.0.1/${aws_instance.crypto_ec2.public_ip}/g\" crypto/settings.py"
    ]
  }
}
