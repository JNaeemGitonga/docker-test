
output "IP" {
  value = "${aws_instance.node_test.public_ip}"
}

output "DNS" {
  value = "${aws_instance.node_test.public_dns}"
}
