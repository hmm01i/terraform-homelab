provider "aws" {
  region     = "us-east-1"
  profile    = "jsohl"
}
data "aws_ami" "centos7" {
  most_recent = true
  owners = ["679593333241"]

  filter {
    name = "name"
    values = ["CentOS Linux 7 x86_64 HVM*"]
  }
}

resource "aws_instance" "chef_server" {
  ami           = "${data.aws_ami.centos7.id}"
  instance_type = "t2.micro"
  key_name      = "atlas"
  security_groups = ["allow_ssh"]
  tags {
    name = "chef_server"
  }
}
        
resource "aws_instance" "elastic_search" {
  ami           = "${data.aws_ami.centos7.id}"
  instance_type = "t2.micro"
  key_name      = "atlas"
  security_groups = ["allow_ssh"]
  tags {
    name = "elastic_search"
  }
}

 resource "aws_security_group" "ssh_from_home" {
  name = "allow_ssh"
  description = "allow ssh from home"
  
  ingress {
    from_port = 0
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
