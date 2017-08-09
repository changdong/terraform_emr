# Create a subnet to launch our instances into

resource "aws_subnet" "emr_vpc_subnet_public" {
  vpc_id                  = "${aws_vpc.emr_vpc.id}"
  cidr_block              = "10.111.1.0/24"
  map_public_ip_on_launch = true

  tags {
    Name = "emr_vpc_subnet_public"
  }
}

resource "aws_route_table" "route_table_public" {
    vpc_id = "${aws_vpc.emr_vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.emr_gw.id}"
    }

    tags {
        Name = "Public Subnet"
    }
}

resource "aws_route_table_association" "rt-association-public" {
    subnet_id = "${aws_subnet.emr_vpc_subnet_public.id}"
    route_table_id = "${aws_route_table.route_table_public.id}"
}
