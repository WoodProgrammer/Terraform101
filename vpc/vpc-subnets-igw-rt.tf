variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}


provider "aws" {
  region = "us-east-2"
  access_key = "${var.AWS_ACCESS_KEY}"
  secret_key = "${var.AWS_SECRET_KEY}"
}


resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  tags {
    Name = "SecurityVPC"
  }
}


### PUBLIC SUBNETS
resource "aws_subnet" "Public-1" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-2a"
  tags {
    Name = "Public-1"
  }
}

resource "aws_subnet" "Public-2" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-2b"
  tags {
    Name = "Public-2"
  }
}
#####################################


###### PRIVATE SUBNET
resource "aws_subnet" "Private-1" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-2a"
  tags {
    Name = "Private-1"
  }
}

resource "aws_subnet" "Private-2" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-2b"
  tags {
    Name = "Private-2"
  }
}
############


#### ROUTE TABLE SET THE IGW

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "SecurityInternetGateWay"
  }
}
###################################


resource "aws_route_table" "r" {
  vpc_id = "${aws_vpc.default.id}"

}

