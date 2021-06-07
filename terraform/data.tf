data "template_file" "init" {
  template = file(var.ec2_bootstrap_data)
}

data "template_file" "start_docker" {
  template = file(var.ec2_docker_data)
}

data "template_file" "docker_env" {
  template = file(var.ec2_docker_env)
}

data "archive_file" "lambda_zip_file" {
  type        = "zip"
  output_path = "./tmp/get_orders_details.zip"
  source {
    content  = file(var.lambda_file_data)
    filename = "lambda_function.py"
  }
}