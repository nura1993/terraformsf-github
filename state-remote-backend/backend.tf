terraform {
  backend "s3" {
    bucket = "statefiletos3"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}
