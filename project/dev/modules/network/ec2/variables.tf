variable "ami_id" {}
variable "instance_type" {}
variable "ec2_count" {}
variable "subnet_ids" {
  type = list(string)
}
variable "vpc_id" {}
variable "alb_sg_id" {}
variable "target_group_arn" {}
