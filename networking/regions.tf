module "us-east-1" {
  source          = "./region"
  region          = "us-east-1"
  base_cidr_block = var.base_cidr_block
}

module "ap-south-1" {
  source          = "./region"
  region          = "ap-south-1"
  base_cidr_block = var.base_cidr_block
}

