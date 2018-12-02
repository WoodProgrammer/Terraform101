variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "PUBLIC_KEY" {}


provider "aws" {
  region = "us-east-2"
  access_key = "${var.AWS_ACCESS_KEY}"
  secret_key = "${var.AWS_SECRET_KEY}"
}

resource "aws_key_pair" "emir-key" {
  key_name   = "emir-key"
  public_key = "${var.PUBLIC_KEY}"
}

resource "aws_instance" "web" {
  ami           = "ami-0f65671a86f061fcd"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.emir-key.key_name}"
  iam_instance_profile = "${aws_iam_instance_profile.ec2-role.name}"

  tags {
    Name = "ec2-s3-Test"
  }
}
