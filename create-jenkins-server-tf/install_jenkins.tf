//This Terraform Template creates a jenkins server on AWS EC2 Instance
//Jenkins server will run on Amazon Linux 2023 with custom security group
//allowing SSH (22) and TCP (8080) connections from anywhere.
//User needs to select appropriate variables from "variable.tf" file when launching the instance.

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.region
}

data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }
}
resource "aws_instance" "tf-jenkins-server" {
  ami                    = data.aws_ami.al2023.id
  instance_type          = var.instancetype
  key_name               = var.mykey
  vpc_security_group_ids = [aws_security_group.tf-jenkins-sec-gr.id]
  user_data              = file("install-jenkins.sh")
  root_block_device {
    volume_size = 16
  }
  tags = {
    Name = var.tags
  }

}

# terraform taint forpasswd 

resource "null_resource" "get_jenkins_password" {
  depends_on = [aws_instance.tf-jenkins-server]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.ssh/${var.mykey}.pem")
    host        = aws_instance.tf-jenkins-server.public_ip
    timeout     = "5m"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo bash -c  'while [ ! -f /var/lib/jenkins/secrets/initialAdminPassword ];do echo WAITING; sleep 5; done'",
      "sudo bash -c 'echo \"JENKINS PASSWORD: $(cat /var/lib/jenkins/secrets/initialAdminPassword)\"'"

    ]
  }
}

resource "aws_security_group" "tf-jenkins-sec-gr" {
  name = var.secgrname
  tags = {
    Name = var.secgrname
  }

  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    protocol    = "tcp"
    to_port     = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = -1
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "jenkins" {
  value = "http://${aws_instance.tf-jenkins-server.public_ip}:8080"
}
