
variable aws_region {
  type        = string
  description = "This is for my region"
  default     = "us-east-1"
}
variable public_cidr {
    type = list
    description = " list of  public cidr"
    default = ["10.0.0.0/24", "10.0.2.0/24"]
}

variable priv_cidr {
    type = list
    description = "list of  private cidr"
     default =  ["10.0.1.0/24", "10.0.3.0/24"]

}
variable cidr_database {
    type = list
    description = "list of  cidr database"
    default = ["10.0.5.0/24","10.0.7.0/24"]
}

  variable my_AZ {
    type = list
    description = "list of my public AZ"
    default = ["us-east-1a", "us-east-1b"]
}
  
  variable priv_AZ {
        type = list
        description = "list of azs"
        default = ["us-east-1a", "us-east-1b"]
}
   variable database_az {
        type = list
        description =  " list of public database"
        default = ["us-east-1a", "us-east-1b"]
    }

