terraform {
  backend "s3" {
    bucket = "[your s3 bucket]"
    key    = "[your tfstate file name]"
    region = "ap-northeast-1"
  }
}

provider "aws" {
  region = local.region
}
