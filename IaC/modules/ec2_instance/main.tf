data "aws_ami" "amazon_linux_2" {

  most_recent = var.most_recent

  filter {
    name   = var.ami_name
    values = [var.ami_value]
  }

  filter {
    name   = var.ebs_name
    values = [var.ebs_value]
  }

  owners = [var.ami_owner]
}

data "aws_key_pair" "keypairs" {
  for_each = var.instance_configurations

  key_name           = each.value.key_name
  include_public_key = each.value.include_public_key
}

resource "aws_instance" "bastion" {
  for_each               = { for i, instance_configuration in var.instance_configurations : i => instance_configuration }
  ami                    = each.value.ami_id
  instance_type          = each.value.instance_type
  subnet_id              = var.subnet_id
  key_name               = each.value.key_name
  vpc_security_group_ids = [var.security_groups[each.value.index]]

  metadata_options {
    http_tokens = each.value.metadata_version
  }

  root_block_device {
    volume_size = each.value.root_ebs_size
    volume_type = var.volume_type
  }

  tags = {
    Name  = format("%s-%s", var.project, each.value.os_type)
    Owner = var.owner
  }
}

/*
resource "aws_ebs_volume" "ebs_volumes" {
  for_each = { for i, ebs in var.ebs_configurations : i => ebs }

  size              = each.value.size
  type              = each.value.type
  availability_zone = each.value.az
}

resource "aws_volume_attachment" "ebs_att" {
  for_each = { for i, ebs in var.ebs_configurations : i => ebs }

  device_name = each.value.device_name
  volume_id   = aws_ebs_volume.ebs_volumes[each.key].id
  instance_id = aws_instance.bastion[each.key].id
}
*/
