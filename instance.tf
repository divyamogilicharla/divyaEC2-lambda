resource "aws_instance" "webserver" {
  ami           = "ami-076e3a557efe1aa9c"
  instance_type = "t2.micro"
  #tags = {
  #  Type = "WebServer"
  #}
  key_name = "keypair-1"

  user_data = <<EOF
  #!/bin/bash
  sudo su
  yum update -y
  yum install httpd -y
  cd /var/www/html
  echo "This is a Sample Webserver" > index.html
  service httpd start
  chkconfig httpd on
  EOF
  }
/*
resource "aws_ec2_tag" "webserver" {
  resource_id = aws_instance.webserver.id
  key         = "Type"
  value       = "WebServer"
}
*/

resource "aws_ec2_tag" "webserver" {
  for_each = { "Name" : "Lambda-Instace", "Type" : "WebServer" }

  resource_id = aws_instance.webserver.id
  key         = each.key
  value       = each.value
}