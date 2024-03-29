resource "aws_instance" "example" {
  ami                    = "ami-0eb82ff4044778f35"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]
  user_data              = <<-EOF
              #!/bin/bash
              echo "HELLO, WORLD! This is a simple web server." > index.html
              nohup busybox httpd -f -p ${var.server_port} &
              EOF

  user_data_replace_on_change = true


  tags = {
    Name = " Hello World"
  }
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"


  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow incoming requests from any IP address

  }


}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8080
}

output "public_ip" {
  value       = aws_instance.example.public_ip
  description = "The public IP address of the web server"

}
