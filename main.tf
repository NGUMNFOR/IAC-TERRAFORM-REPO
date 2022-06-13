

locals {
  mandatory_tags = {

    line_of_business        = "hospital"
    ado                     = "jude"
    tier                    = "web"
    operational_environment = upper(terraform.workspace)
    tech_poc_primary        = "ngumjuden1234@gmail.com"
    tech_poc_secondary      = "nngumjude@gmail.com"
    application             = "http"
    builder                 = "ngumjude@gmail.com"
    application_ower        = "j.nfor@yahoo.co"
    vpc                     = "WEB"
    cell_name               = "WEB"
    component_name          = "IAC-TERRAFORM-REPO"

  }
  vpc_id = aws_vpc.ngumvpc.id

}

resource "aws_vpc" "ngumvpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true


tags = {
    Name = "ngumvpc"
}

}

# internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = local.vpc_id

  tags = {
    Name = "ngumvpcigw"
}
}

resource "aws_subnet" "pubsubnet1" {
  vpc_id                  = local.vpc_id
  cidr_block              = var.public_cidr[0]
  availability_zone       = var.my_AZ[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "pubsubnet1"
}

}


resource "aws_subnet" "pubsubnet2" {
  vpc_id                  = local.vpc_id
  cidr_block              = var.public_cidr[1]
  availability_zone       = var.my_AZ[1]
  map_public_ip_on_launch = true

  
  tags = {
    Name = "pubsubnet1"
}

}

resource "aws_subnet" "priv_sub1" {
  vpc_id            = local.vpc_id
  cidr_block        = var.priv_cidr[0]
  availability_zone = var.priv_AZ[0]
}
resource "aws_subnet" "priv_sub2" {
  vpc_id            = local.vpc_id
  cidr_block        = var.priv_cidr[1]
  availability_zone = var.priv_AZ[1]
}
resource "aws_subnet" "database_subnet1" {
  vpc_id            = local.vpc_id
  cidr_block        = var.cidr_database[0]
  availability_zone = var.database_az[0]
}
resource "aws_subnet" "database_subnet2" {
  vpc_id            = local.vpc_id
  cidr_block        = var.cidr_database[1]
  availability_zone = var.database_az[1]
}

#Creating routs

resource "aws_route_table" "pub_rt1" {
  vpc_id = aws_vpc.ngumvpc.id

}

resource "aws_route_table" "pub_rt2" {
  vpc_id = aws_vpc.ngumvpc.id

}

# Rout Table Association
resource "aws_route_table_association" "rout_assiocia1" {
  subnet_id      = aws_subnet.pubsubnet1.id
  route_table_id = aws_route_table.pub_rt1.id
}
resource "aws_route_table_association" "rout_assiocia2" {
  subnet_id      = aws_subnet.pubsubnet2.id
  route_table_id = aws_route_table.pub_rt2.id
}

#Route

resource "aws_route" "pub_rt1" {
  route_table_id            = aws_route_table.pub_rt1.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.igw.id
  depends_on                = [aws_route_table.pub_rt1]
}

resource "aws_route" "pub_rt2" {
  route_table_id            = aws_route_table.pub_rt2.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.igw.id
  depends_on                = [aws_route_table.pub_rt2]
}

#Default rout table

resource "aws_default_route_table" "default_rout" {
  default_route_table_id = aws_vpc.ngumvpc.default_route_table_id
}
  /*route {
    cidr_block = "0.0.0.0/0"
    nateway_id = aws_nat_gateway.ngw_1.id
  }
 */
#Natgateway 

resource "aws_nat_gateway" "ngw_1" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.pubsubnet1.id
 
  depends_on = [aws_internet_gateway.igw]
}

#Elastic IP address

resource "aws_eip" "eip" {
 depends_on  =  [aws_internet_gateway.igw]  
  vpc      = true
}

 /*tags = {
    Name = "gw NAT"
  }
*/