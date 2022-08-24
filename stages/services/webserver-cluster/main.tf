provider "aws" {
  region = "us-east-1"
}
module "webserver-staging" {
  source = "../../../modules/services/webserver-cluster"

  cluster_name  = "webserver-stage"
  instance_type = "t2.micro"
  min_size      = 2
  max_size      = 5
}