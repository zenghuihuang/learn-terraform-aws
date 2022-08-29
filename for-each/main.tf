resource "aws_iam_user" "animal" {
    for_each = toset(var.user_name)
    name = each.value
  
}

module "webserver-cluster1"  {
    source = "../modules/services/webserver-cluster"
    cluster_name = "Jupiter"

    instance_type = "m4.large"
    min_size = 2
    max_size = 10

   custom_tags={
        Owner = "front-end"
        ManagedBy = "terraform"
    } 
  
}