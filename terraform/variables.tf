variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "accountId" {}
variable "key_name" {}
variable "key_path" {}

variable "region" {
  default = "eu-central-1"
}

variable "aws_ami" {
  description = "The AWS AMI."
  default     = "ami-05f7491af5eef733a"
}

variable "aws_instance_type" {
  description = "The AWS Instance Type."
  default     = "t2.xlarge"
}

variable "tag_prj" {
  default = "demo-aws-confluent"
}

variable "ec2_bootstrap_data" {
  default = "./scripts/bootstrap.sh"
}

variable "ec2_docker_env" {
  default = "../.env"
}

variable "ec2_docker_data" {
  default = "./scripts/start-containers.sh"
}


variable "lambda_file_data" {
  default = "../microservices/get_order_details.py"
}