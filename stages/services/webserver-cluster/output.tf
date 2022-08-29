output "alb_dns_name" {
  value= module.webserver-staging.alb_dns_name
  description = "The domain name of the application load balancer"
  
}

output "iam_all_arns" {
  value = module.webserver-staging.iam_all_arns
  description = "The ARN of all IAM users"
  
}