resource "aws_emr_cluster" "emr-test-cluster" {
  name          = "emr-test-chang"
  release_label = "emr-5.7.0"
  applications  = ["Spark"]

  termination_protection = false
  keep_job_flow_alive_when_no_steps = true

  ec2_attributes {
    subnet_id                         = "${aws_subnet.main.id}"
    emr_managed_master_security_group = "${aws_security_group.sg.id}"
    emr_managed_slave_security_group  = "${aws_security_group.sg.id}"
    instance_profile                  = "${aws_iam_instance_profile.emr_profile.arn}"
  }

  master_instance_type = "m3.xlarge"
  core_instance_type   = "m3.xlarge"
  core_instance_count  = 1

  tags {
    role     = "rolename"
    env      = "env"
  }

  service_role = "${aws_iam_role.iam_emr_service_role.arn}"
}
