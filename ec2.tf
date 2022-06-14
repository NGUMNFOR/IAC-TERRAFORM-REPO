
#! /bin/bash
# Instance Identity Metadata Reference - https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-identity-documents.html



# Count is only used for conditions
resource "aws_instance" "web" {
  #count = var.create_instance ? 1 : 0
  ami                         = "ami-0022f774911c1d690"
  instance_type               = "t2.micro"
  subnet_id                    = aws_subnet.database_subnet1.id
  user_data                   = file("${path.module}/template/app1-http.sh")
  vpc_security_group_ids      = [aws_security_group.allow_http.id]

tags_all = {
  Name = "web"
}

}

data "aws_ssm_parameter" "ami" {
  name = "latest_golden_ami"
}

resource  "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow http inbound traffic 1"
   vpc_id      = local.vpc_id

  ingress {
    description = "http from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["69.243.11.88/32"]
  }

ingress {
    description = "http from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["69.243.11.88/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
