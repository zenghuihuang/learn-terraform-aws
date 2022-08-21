### Description

For simplicity, this example deploys a simple web server on a EC2 instance in default VPC with 
public subnets, therefore it is not secure from internet attacks. 

In real-world production enviroments, we should use always private subnets. 

To view the content of this simple web server: 

`curl http://public-ip-of-the-EC2-instance: 8080`

[Example](webserver.png)