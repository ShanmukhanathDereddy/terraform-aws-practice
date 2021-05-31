#Instance DB #

#Create instance
resource "aws_instance" "db" {
  for_each          = var.db_instance_names
  ami               = data.aws_ami.amznlnx.id
  instance_type     = "t2.micro"
  availability_zone = var.availability_zone_names[0]
  key_name          = aws_key_pair.user-key.key_name
  vpc_security_group_ids = [
    aws_security_group.administration.id,
    aws_security_group.db.id
  ]
  subnet_id = aws_subnet.db.id
  user_data = file("scripts/first-boot-db.sh")
  tags = {
    Name = each.key
  }
}


#Attach floating ip on instance db
resource "aws_eip" "public_db" {
  for_each   = var.db_instance_names
  vpc        = true
  instance   = aws_instance.db[each.key].id
  depends_on = [aws_internet_gateway.gw]
  tags = {
    Name = "public-db-${each.key}"
  }
}

/*
#create volume
resource "aws_ebs_volume" "db" {
  availability_zone = "ap-south-1b"
  size              = 10
}

#Attach volume to instance
resource "aws_volume_attachment" "db" {
  device_name  = "/dev/xvdh"
  force_detach = true
  volume_id    = aws_ebs_volume.db.id
  instance_id  = aws_instance.db.id
}
*/