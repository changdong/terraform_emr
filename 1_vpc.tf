# Create a VPC to launch our instances into
resource "aws_vpc" "emr_vpc" {
  cidr_block = "10.111.0.0/16"

  tags {
    Name = "terrform_emr_vpc"
  }
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "emr_gw" {
  vpc_id = "${aws_vpc.emr_vpc.id}"

  tags {
    Name = "Terraform_EMR_Gateway"
  }

}

# Grant the VPC internet access on its main route table
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.emr_vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.emr_gw.id}"
}

