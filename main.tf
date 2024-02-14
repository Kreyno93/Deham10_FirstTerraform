terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 5.35.0"
        }
    }
    
}

resource "aws_eip" "Deham10" {
    instance = aws_instance.Deham10.id
}

output "Instance_Id" {
    description = "The ID of the instance"
    value       = aws_instance.Deham10.id
}
