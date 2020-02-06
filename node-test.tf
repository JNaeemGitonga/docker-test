# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# data "aws_ami" "amzLinx2" { 
#* here is info about this https://www.terraform.io/docs/providers/aws/d/ami.html#filter
#* you can use this to finde an image
# }

resource "aws_security_group" "node_test_allow_ssh" {
  name        = "node_test_allow_ssh"
  description = "Allow SSH inbound traffic from my mac"
  vpc_id      = "vpc-b53991cf"

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["73.207.47.46/32"] #! canyouseeme.org
  }

  egress {
    #! without this rule you will not be able to ping from within container
    from_port   = 8
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    #! without this rule u cannot pull from docker...WHY!? 
    #! probably because dockerhub use https and this is the port that correspondes to that.
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    #* this sets up outbound traffic for updting our instance and downloading from in
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "node_test" {
  ami             = "ami-08bc77a2c7eb2b1da" #* ubuntu 16.0.4 image 6-bit
  instance_type   = "t2.micro"
  key_name        = "node-test"
  security_groups = [aws_security_group.node_test_allow_ssh.name]

  tags = {
    Name = "Declarative IaC with Terraform -- Node Test"
  }
}
