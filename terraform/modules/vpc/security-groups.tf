// Used by the jump host. Only for demo purposes.
resource "aws_security_group" "allow_all_sg" {
  name   = "allow-inbound-outbound-sg"
  vpc_id = aws_vpc.vpc.id

  ingress {
    description = "Allow all inbound traffic"
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = [aws_vpc.vpc.cidr_block, "0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = [aws_vpc.vpc.cidr_block, "0.0.0.0/0"]
  }
}
