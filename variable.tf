locals {
  region = "ap-northeast-1"

  iamrole = {
    lambda_basic_role_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  }
}

variable "slack_webhook_uri" {
  description = "slack webhook uri"
  default     = ""
}
