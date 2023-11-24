data "aws_vpc" "vpc" {
  id = var.vpc_id
}

resource "aws_security_group" "interface_endpoint_sg" {
  name        = "${var.clusters_name_prefix}-interface-endpoint-sg"
  vpc_id      = data.aws_vpc.vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
