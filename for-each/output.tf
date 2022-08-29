output "all_users"{
    #value = aws_iam_user.animal
    value = values(aws_iam_user.animal)[*].arn
}