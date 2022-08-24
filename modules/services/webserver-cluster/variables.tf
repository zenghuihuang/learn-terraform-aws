variable "cluster_name" {
  description = "The name of the cluster"
  type        = string

}

variable "region" {
  type    = string
  default = "us-east-1a"
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8080
}

variable "instance_type" {
  description = "The type of EC2 instance"
  type        = string

}

variable "min_size" {
  description = "The minimum number of EC2 instaces in the ASG"
  type        = number
}

variable "max_size" {
  description = "The maximum number of EC2 instaces in the ASG"
  type        = number
}
