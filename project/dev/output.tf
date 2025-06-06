output "alb_dns_name" {
  value = module.alb.alb_dns_name
}
output "instance_ips" {
  value = module.ec2.instance_ips
}
