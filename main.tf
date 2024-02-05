provider "aws" {
    region = "us-west-2"

}

resource "aws_instance" "Deham10" {
    ami = "ami-0d442a425e2e0a743"
    instance_type = "t2.micro"
    key_name = "vockey"
    vpc_security_group_ids = ["sg-0b4be3dadc8bc38f1"]
    user_data = <<-EOF
                #!/bin/bash
                sudo yum update -y
                sudo yum install -y httpd
                sudo systemctl start httpd
                sudo systemctl enable httpd
                sudo echo "Hello World from $(hostname -f)" > /var/www/html/index.html
                EOF
    tags = {
        Name = "Deham10"
    }
}
