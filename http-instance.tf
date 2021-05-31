#Instance http

resource "aws_instance" "http" {
  for_each          = var.http_instance_names
  ami               = data.aws_ami.amznlnx.id
  instance_type     = "t2.micro"
  key_name          = aws_key_pair.user-key.key_name
  availability_zone = var.availability_zone_names[1]
  vpc_security_group_ids = [
    aws_security_group.administration.id,
    aws_security_group.web.id
  ]
  subnet_id = aws_subnet.http.id
  user_data = file("scripts/first-boot-http.sh")
  root_block_device {
    volume_type = "standard"
    volume_size = "10"
  }
  tags = {
    Name = each.key
  }
}

# Attach floating ip on instance http
resource "aws_eip" "public_http" {
  for_each   = var.http_instance_names
  vpc        = true
  instance   = aws_instance.http[each.key].id
  depends_on = [aws_internet_gateway.gw]
  tags = {
    Name = "public-http-${each.key}"
  }
}
