resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("new-key-ec2.pub")
}

resource "aws_default_vpc" "default" {
 
}


resource "aws_security_group" "new_security_group" {
  name        = "terraform-sg"
  description = "this is the tf generated security group"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "automate-sg"
  }
}


resource "aws_instance" "my_instance" {
  key_name        = aws_key_pair.deployer.key_name
  security_groups = [aws_security_group.new_security_group.name]
  instance_type   = "t3.micro"
  ami             = "ami-0c1ac8a41498c1a9c"
  user_data = file("install-nginx.sh")

  root_block_device {
    volume_size = 10
    volume_type = "gp3"
  }

  tags = {
    Name = "MyInstance"
  }
}