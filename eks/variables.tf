variable "region" {
  type    = string
  default = "us-east-1"
}

variable "cluster_name" {
  type    = string
  default = "plana"
}

variable "worker_groups_launch_template" {
  default = [
    {
      name                    = "spot"
      override_instance_types = ["t3a.large"]
      asg_desired_capacity    = 2
      asg_min_size            = 2
      asg_max_size            = 2
      kubelet_extra_args      = "--node-labels=node.kubernetes.io/lifecycle=spot"
      public_ip               = false
      tags                    = []
    }
  ]
}

variable "cluster_enabled_log_types" {
  default = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."

  default = [

  ]
}
