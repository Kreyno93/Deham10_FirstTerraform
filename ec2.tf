data "aws_ssm_parameter" "latest_amzn2_ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_instance" "Deham10" {
  ami                    = data.aws_ssm_parameter.latest_amzn2_ami.value
  instance_type          = "t2.micro"
  key_name               = "vockey"
  vpc_security_group_ids = [aws_security_group.Deham10_Public_SG.id]
  subnet_id              = aws_subnet.public_subnet.id
  user_data              = file("userdata.sh")
  tags = {
    Name = "Deham10"
  }
}