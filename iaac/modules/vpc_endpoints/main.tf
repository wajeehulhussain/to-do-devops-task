resource "aws_vpc_endpoint" "endpoints" {
  count               = length(var.interface_service_name)
  service_name        = var.interface_service_name[count.index]
  vpc_id              = var.vpc_id
  vpc_endpoint_type   = var.vpc_endpoint_type_interface
  private_dns_enabled = var.private_dns_enabled
  subnet_ids          = var.subnet_ids
  security_group_ids  = var.security_group_id

  tags = {
    Name  = "${var.project}-${var.tags_service_name[count.index]}"
    Owner = var.owner
  }
}

resource "aws_vpc_endpoint" "s3" {
  service_name      = var.s3_service_name
  vpc_id            = var.vpc_id
  vpc_endpoint_type = var.vpc_endpoint_type_gateway

  tags = {
    Name  = "${var.project}-s3"
    Owner = var.owner
  }
}

resource "aws_vpc_endpoint_route_table_association" "s3_private_table_association" {
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
  route_table_id  = var.route_table_id
}