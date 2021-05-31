resource "aws_security_group" "region" {
  name        = "region"
  description = "Open access within the region"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = [aws_vpc.main.cidr_block]
  }
}

resource "aws_security_group" "Internal-all" {
  name        = "Internal-all"
  description = "Open access within the full Internal network"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = [var.base_cidr_block]
  }
}
