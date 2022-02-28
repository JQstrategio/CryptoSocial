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


  provisioner "remote-exec" {
    inline = [
      //
      // Config environment
      //
      "sudo apt update -y",
      "sudo apt upgrade -y",
      "sudo apt install python pip unzip s3fs awscli -y",

      //
      // Unpack
      //
      "unzip -o CryptoApp.zip",
      "rm CryptoApp.zip",

      //
      // Config for application
      //
      "cd CryptoSocial/app",
      "sudo pip install -r requirements.txt",
      "sed -i \"s/localhost/${aws_instance.crypto_ec2.public_ip}/g\" crypto/settings.py",

      //
      // Mounting s3 bucket to points
      //
      "mkdir bucket",
      "sudo s3fs crypto-s3-bucket ./bucket -o iam_role=\"Crypto-role\" -o allow_other -o default_acl=public-read -o use_cache=/tmp/s3fs -o nonempty",
      "mkdir ../static_cdn",
      "sudo s3fs crypto-s3-bucket ../static_cdn -o iam_role=\"Crypto-role\" -o allow_other -o default_acl=public-read -o use_cache=/tmp/s3fs -o nonempty",

      //
      // Prepare server
      //
      "python3 manage.py migrate",
      "echo 'PREPARING TO RUN SERVER'",

      //
      // Running server
      //
      "sudo nohup python3 manage.py runserver 0:8000 &",
      "sleep 1s",
      "echo 'RUNNING!'"
    ]
  }
}