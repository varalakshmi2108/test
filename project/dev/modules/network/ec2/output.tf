output "instance_ips" {
  value = [for i in aws_instance.web : i.public_ip]
}