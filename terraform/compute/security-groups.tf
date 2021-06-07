resource "aws_security_group" "ec2_sg" {
    name = "ec2-security-group"
    description = "Accept incoming connections."

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "SSH"
    }
    ingress {
        from_port = 8083
        to_port = 8083
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Kafka Connect REST API" 
    }
    ingress {
        from_port = 1099
        to_port = 1099
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "JMX" 
    }
    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"] 
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "demo-aws-confluent"
    }
}

