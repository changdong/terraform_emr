# Our default security group to access the instances over SSH and HTTP
/*
EMR
*/

resource "aws_security_group" "httpsshSG" {
  name        = "EMR_SG"
  description = "EMR_SG"
  vpc_id      = "${aws_vpc.emr_vpc.id}"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from the VPC
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.111.0.0/16", "162.246.216.28/32"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


