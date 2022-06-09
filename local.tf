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