
resource "aws_vpc" ngumvpc {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
}
resource "aws_subnet" pubsubnet1 {
  vpc_id     = local.vpc_id
  cidr_block = var.public_cidr[0]
 availability_zone = var.my_AZ[0]
 map_public_ip_on_launch = true
}
resource "aws_subnet" pubsubnet2 {
  vpc_id     = local.vpc_id
  cidr_block = var.public_cidr[1]
  availability_zone = var.my_AZ[1]
  map_public_ip_on_launch = true
}
resource "aws_subnet" priv_sub1 {
  vpc_id     = local.vpc_id
  cidr_block = var.priv_cidr[0]
  availability_zone = var.priv_AZ [0]
}
resource "aws_subnet" priv_sub2 {
  vpc_id     = local.vpc_id
  cidr_block = var.priv_cidr[1]
  availability_zone = var.priv_AZ [1]
}
resource "aws_subnet" database_subnet1 {
  vpc_id     = local.vpc_id
  cidr_block = var.cidr_database [0]
  availability_zone = var.database_az[0]
}
resource "aws_subnet" database_subnet2 {
  vpc_id     = local.vpc_id
  cidr_block = var.cidr_database [1]
  availability_zone = var.database_az[1]
}

