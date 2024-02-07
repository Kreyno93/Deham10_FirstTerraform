provider "aws" {
    region = "us-west-2"

}

resource "aws_security_group" "Deham10" {
    name        = "Deham10"
    description = "Allow inbound traffic"
    vpc_id      = "vpc-072b249341fa09676"

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
}

resource "aws_instance" "Deham10" {
    ami                    = "ami-0d442a425e2e0a743"
    instance_type          = "t2.micro"
    key_name               = "vockey"
    vpc_security_group_ids = ["sg-0d50b2a0ef6428fc1"]
    user_data              = <<-EOF
                                #!/bin/bash
                                sudo yum update -y
                                sudo yum install -y httpd
                                sudo systemctl start httpd
                                sudo systemctl enable httpd
                                sudo echo "<!DOCTYPE html>
                                                <html lang="en">
                                                <head>
                                                    <meta charset="UTF-8">
                                                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                                                    <title>Futuristic Design</title>
                                                    <style>
                                                        body {
                                                            background-color: #0a0a0a;
                                                            color: #fff;
                                                            font-family: 'Arial', sans-serif;
                                                            margin: 0;
                                                            padding: 0;
                                                            display: flex;
                                                            align-items: center;
                                                            justify-content: center;
                                                            height: 100vh;
                                                        }

                                                        h1 {
                                                            font-size: 3em;
                                                            text-align: center;
                                                            margin-bottom: 20px;
                                                        }

                                                        .container {
                                                            background-color: #1f1f1f;
                                                            padding: 20px;
                                                            border-radius: 10px;
                                                            box-shadow: 0 0 10px rgba(255, 255, 255, 0.3);
                                                        }

                                                        p {
                                                            font-size: 1.2em;
                                                            line-height: 1.6;
                                                        }

                                                        button {
                                                            background-color: #3498db;
                                                            color: #fff;
                                                            border: none;
                                                            padding: 10px 20px;
                                                            font-size: 1em;
                                                            cursor: pointer;
                                                            border-radius: 5px;
                                                            transition: background-color 0.3s;
                                                        }

                                                        button:hover {
                                                            background-color: #2980b9;
                                                        }
                                                    </style>
                                                </head>
                                                <body>

                                                    <div class="container">
                                                        <h1>Welcome to the Future</h1>
                                                        <p>This is a futuristic HTML template. Feel free to customize it according to your needs.</p>
                                                        <button>Get Started</button>
                                                    </div>

                                                </body>
                                                </html>
                                                " > /var/www/html/index.html
                                EOF
    tags = {
        Name = "Deham10"
    }
        provisioner "local-exec" {
        command = "bash update_security_group_ids.sh"
    }
}

output "Instance_Id" {
    description = "The ID of the instance"
    value       = aws_instance.Deham10.id
}
