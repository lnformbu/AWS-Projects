# I am using terraform cloud for my remote state configuration. 
data "terraform_remote_state" "vpc" {
  backend = "remote"

  config = {
    organization = "AWS-100DaysofDevOps"
    workspaces = {
      name = "100DaysDevOps"
    }
  }
}
