resource "aws_instance" "example" {
  ami           = "ami-090fa75af13c156b4"
  instance_type = "t2.micro"
}

