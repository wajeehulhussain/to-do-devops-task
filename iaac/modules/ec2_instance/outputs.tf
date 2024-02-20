output "linux_ami_id" {
  value = data.aws_ami.amazon_linux_2.image_id
}

output "bastion_ip" {
  value = "${aws_instance.bastion["linux-1"].private_ip}/32"
}