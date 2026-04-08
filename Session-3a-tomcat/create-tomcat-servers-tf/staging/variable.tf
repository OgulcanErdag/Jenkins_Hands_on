//variable "aws_secret_key" {}
//variable "aws_access_key" {}

variable "region" {
  default = "us-east-1"
}

variable "mykey" {
  default = "ogi-us-key"
}

variable "instancetype" {
  default = "t3.micro"
}

variable "secgrname" {
  default = "TomcatServerSecurityGroup"
}
