variable "user_name" {
    description = "The name of IAM users"
    type = list(string)
    default = [ "Rome","London","Paris" ]
  
}
