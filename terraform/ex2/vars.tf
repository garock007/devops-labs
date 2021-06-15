variable instancetype {
  type        = string
  description = "Type de l’instance aws"
  default     = "t2.nano"
}

variable aws_common_tag {
  type        = map
  description = "Le tags aws"
  default = {
    Name = "ec2-training"
  }
}
