output "public_ip" {
  value       = aws_lb.example.dns_name
  description = "The domain name of the load balancer"

}

output "alb_dns_name" {
  value= aws_lb.example.dns_name
  description = "The domain name of the application load balancer"
  
}

output "first_iam_arn" {
  value = aws_iam_user.example[0]
  description = "The ARN for the first IAM user"
  
}

output "iam_all_arns" {
  value = aws_iam_user.example[*].arn
  description = "The ARN of all IAM users"
  
}


