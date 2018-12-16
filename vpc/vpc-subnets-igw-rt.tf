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


#### Public Route Table
resource "aws_route_table" "r" {
  vpc_id = "${aws_vpc.main.id}"
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }
}

resource "aws_route_table_association" "a_1" {### public (asso), route to the IGW
  subnet_id      = "${aws_subnet.Public-1.id}"
  route_table_id = "${aws_route_table.r.id}"
}
resource "aws_route_table_association" "a_2" {### public (asso), route to the IGW
  subnet_id      = "${aws_subnet.Public-2.id}"
  route_table_id = "${aws_route_table.r.id}"
}


#### end ###

###Create EIP
resource "aws_eip" "tuto_eip" {
  vpc      = true
  depends_on = ["aws_internet_gateway.gw"]
}



####

#### CREATE NAT GATEWAY
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = "${aws_eip.tuto_eip.id}"
  subnet_id     = "${aws_subnet.Public-2.id}"
}

####

#### Private Route Table
resource "aws_route_table" "r_private" {
  vpc_id = "${aws_vpc.main.id}"
  
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat_gateway.id}"
  }
}

resource "aws_route_table_association" "a_3" {### public (asso), route to the IGW
  subnet_id      = "${aws_subnet.Private-1.id}"
  route_table_id = "${aws_route_table.r_private.id}"
}
resource "aws_route_table_association" "a_4" {### public (asso), route to the IGW
  subnet_id      = "${aws_subnet.Private-2.id}"
  route_table_id = "${aws_route_table.r_private.id}"
}
#### end #### 
