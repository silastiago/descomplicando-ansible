terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "k8s-master" {
  count = 1
  ami = "ami-07efac79022b86107"
  instance_type = "t3a.medium"
  key_name = "servidor"
  tags = {
    Name = "k8s-master"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}", 
                            "${aws_security_group.acesso-web.id}"}"
                            ]
}

resource "aws_instance" "k8s-worker" {
  count = 2
  ami = "ami-07efac79022b86107"
  instance_type = "t3a.medium"
  key_name = "servidor"
  tags = {
    Name = "k8s-worker"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}",
                            "${aws_security_group.acesso-web.id}"]
}

resource "null_resource" "ansible" {

  triggers = {
    cluster_instance_ids = "${join(",", local_file.AnsibleInventory.*.id)}"
  }

  provisioner "local-exec" {
    command = "sleep 20;ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ../ansible/inventory ../ansible/playbook.yml"
    }

}


