resource "aws_instance" "ec2-demo-aws-confluent" {
    ami = var.aws_ami
    instance_type = var.aws_instance_type
    key_name = var.key_name
    vpc_security_group_ids = ["${aws_security_group.ec2_sg.id}"] 
    source_dest_check = false
    tags = {
        Name = "demo-aws-confluent"
    }
}

resource "null_resource" "vm_provisioners" {
  depends_on = [aws_instance.ec2-demo-aws-confluent]

  // Copy bootstrap script to the VM
  provisioner "file" {
    content     = var.file_init.rendered
    destination = "/tmp/bootstrap_vm.sh"

    connection {
      type = "ssh"
	  user = "ubuntu"
      private_key = "${file(var.key_path)}"
      host     = aws_instance.ec2-demo-aws-confluent.public_ip
    }
  }
  
  // Execute bootstrap script on the VM to install tools, Docker & Docker Compose.
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap_vm.sh",
      "/tmp/bootstrap_vm.sh",
    ]

    connection {
      type = "ssh"
	  user = "ubuntu"
      private_key = "${file(var.key_path)}"
      host     = aws_instance.ec2-demo-aws-confluent.public_ip
    }
  }
  
    // Copy docker-bootstrap script to the VM
  provisioner "file" {
    content     = var.docker_init.rendered
    destination = "/tmp/start-containers.sh"

    connection {
      type = "ssh"
	  user = "ubuntu"
      private_key = "${file(var.key_path)}"
      host     = aws_instance.ec2-demo-aws-confluent.public_ip
    }
  }
  
  provisioner "file" {
    content     = var.docker_env.rendered
    destination = "/tmp/environment-variable.env"

    connection {
      type = "ssh"
	  user = "ubuntu"
      private_key = "${file(var.key_path)}"
      host     = aws_instance.ec2-demo-aws-confluent.public_ip
    }
  }
  
  // Execute docker-bootstrap script on the VM.
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/start-containers.sh",
      "/tmp/start-containers.sh",
    ]

    connection {
      type = "ssh"
	  user = "ubuntu"
      private_key = "${file(var.key_path)}"
      host     = aws_instance.ec2-demo-aws-confluent.public_ip
    }
  }
}