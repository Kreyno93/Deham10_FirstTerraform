resource "aws_instance" "Deham10" {
    ami                    = "ami-0d442a425e2e0a743"
    instance_type          = "t2.micro"
    key_name               = "vockey"
    vpc_security_group_ids = [aws_security_group.Deham10_Public_SG.id]
    subnet_id              = aws_subnet.public_subnet.id
    user_data = file("userdata.sh")
    tags = {
        Name = "Deham10"
    }
}