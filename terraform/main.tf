provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.region
}

module "compute" {
  source = "./compute"
  aws_ami = var.aws_ami
  aws_instance_type = var.aws_instance_type
  key_name = var.key_name
  key_path = var.key_path
  file_init = data.template_file.init
  docker_init = data.template_file.start_docker
  docker_env = data.template_file.docker_env
}

module "lambda" {
  source = "./lambda"
  lambda_archive_file = data.archive_file.lambda_zip_file
  region = var.region
  accountId = var.accountId
}

module "storage" {
  source = "./storage"
}