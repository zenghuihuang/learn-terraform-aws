resource "aws_iam_user" "animal" {
    for_each = toset(var.user_name)
    name = each.value
  
}