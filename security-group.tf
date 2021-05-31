#security  group configuration

#default administration port
resource "aws_security_group" "administration" {
  name        = "administration"
  description = "Allows default administration service"
  vpc_id      = aws_vpc.terraform.id
  tags = {
    Name = "administration"
  }

  #open ssh port
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #allow icmp
  ingress {
    from_port   = 7
    to_port     = 7
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #open access to public network
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

#open web port
resource "aws_security_group" "web" {
  name        = "web"
  description = "Allow web ingress traffic"
  vpc_id      = aws_vpc.terraform.id
  tags = {
    Name = "web"
  }

  #open http port
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #open https port
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #open access to public network
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

#open database traffic
resource "aws_security_group" "db" {
  name        = "db"
  description = "Allow DB Ingress traffic"
  vpc_id      = aws_vpc.terraform.id
  tags = {
    Name = "DB"
  }

  #db port
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #open access to public network
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}