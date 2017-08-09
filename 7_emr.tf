provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_key_pair" "auth" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

resource "aws_emr_cluster" "tf-test-cluster" {
  name          = "emr-test-chang"
  release_label = "emr-5.7.0"
  applications  = ["Spark"]

  ec2_attributes {
    subnet_id                         = "${aws_subnet.emr_vpc_subnet_public.id}"
    emr_managed_master_security_group = "${aws_security_group.EMRSG.id}"
    emr_managed_slave_security_group  = "${aws_security_group.EMRSG.id}"
    instance_profile                  = "${aws_iam_instance_profile.emr_profile.arn}"
  }

  master_instance_type = "m3.xlarge"
  core_instance_type   = "m3.xlarge"
  core_instance_count  = 1

  tags {
    role     = "rolename"
    dns_zone = "env_zone"
    env      = "env"
    name     = "name-env"
  }

  service_role = "${aws_iam_role.iam_emr_service_role.arn}"
}

