resource "aws_security_group" "web_sg" {
name = "devops-web-sg"
vpc_id = var.vpc_id

ingress {
from_port = 22
to_port = 22
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

ingress {
from_port = 8080
to_port = 8080
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

ingress {
from_port = 8081
to_port = 8081
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

ingress {
from_port = 80
to_port = 80
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

ingress {
<<<<<<< HEAD
from_port = 8080
to_port = 8080
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

ingress {
from_port = 8081
to_port = 8081
=======
from_port = 9090
to_port = 9090
>>>>>>> a39b543 (update security group add prometheus 9090)
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}
}

resource "aws_instance" "web" {
ami = var.ami
instance_type = var.instance_type
key_name = var.key_name

subnet_id = var.subnet_id
vpc_security_group_ids = [aws_security_group.web_sg.id]
associate_public_ip_address = true

user_data = <<-EOF
#!/bin/bash
apt update -y
apt install docker.io -y
systemctl start docker
systemctl enable docker
EOF

tags = {
Name = var.instance_name
}
}