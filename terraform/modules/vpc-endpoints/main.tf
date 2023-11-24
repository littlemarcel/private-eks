resource "aws_vpc_endpoint" "interface_endpoints" {
  for_each            = toset(var.interface_endpoints_list)
  vpc_id              = var.vpc_id
  service_name        = each.value
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.private_subnet_ids_list
  security_group_ids  = aws_security_group.interface_endpoint_sg.*.id
  // It is important to be set to true, so that AWS Service url resolves into a private VPC IP
  private_dns_enabled = true

  dns_options {
    dns_record_ip_type                             = "ipv4"
    private_dns_only_for_inbound_resolver_endpoint = "false"
  }

  tags = merge(
    var.common_tags,
    {
      Name      = "${var.clusters_name_prefix}-interface-endpoint-${each.value}"
      ManagedBy = "terraform"
    }
  )
}

resource "aws_vpc_endpoint" "gateway_endpoints" {
  for_each          = toset(var.gateway_endpoints_list)
  vpc_id            = var.vpc_id
  service_name      = each.value
  vpc_endpoint_type = "Gateway"
  route_table_ids   = var.private_rtb_ids_list

  tags = merge(
    var.common_tags,
    {
      Name      = "${var.clusters_name_prefix}-gateway-endpoint-${each.value}"
      ManagedBy = "terraform"
    }
  )
}
