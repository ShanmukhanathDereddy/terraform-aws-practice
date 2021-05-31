#variables file for AWS EC2

variable "availability_zone_names" {
  type    = list(string)
  default = ["ap-south-1a", "ap-south-1b"]
}


variable "vpc_cidr" {
  type    = string
  default = "192.168.0.0/16"
}

variable "network_http" {
  type = map(string)
  default = {
    subnet_name = "subnet-http"
    cidr        = "192.168.1.0/24"
  }
}

variable "http_instance_names" {
  type    = set(string)
  default = ["http-instance-1", "http-instance-2"]
}

variable "network_db" {
  type = map(string)
  default = {
    subnet_name = "subnet-db"
    cidr        = "192.168.2.0/24"
  }
}
variable "db_instance_names" {
  type    = set(string)
  default = ["db-instance-1", "db-instance-2", "db-instance-3"]
}

