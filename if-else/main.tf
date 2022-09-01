module "if-else" {
  source = "./modules"

  #cloudwatch_full_access = true
  cloudwatch_full_access = false
  iam_user               = "Apple"
}