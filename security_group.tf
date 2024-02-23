resource "aws_security_group" "Deham10_Public_SG" {
  name        = "Deham10"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.Deham10_VPC.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Deham10_Public_SG"
  }
}

resource "aws_security_group" "private_sg" {
  name        = "PrivateSecurityGroup"
  description = "Allow outbound traffic"
  vpc_id      = aws_vpc.Deham10_VPC.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}