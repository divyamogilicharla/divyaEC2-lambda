output "ec2" {
  value = aws_instance.webserver.id
}
output "public_ip" {
  value = aws_instance.webserver.public_ip
}