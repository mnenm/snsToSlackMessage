# SnsToSlackMessage

send message to slack channel from AWS SNS

## Overview

message -> SNS Topic -> lambda -> slack webhook

## Environments

|Key|Description|
|---|-----------|
|TF_VAR_slack_webhook_uri|slack webhook uri|

## Setting

main.tf

```
terraform {
  backend "s3" {
    bucket = "[your s3 bucket]"
    key    = "[your tfstate file name]"
    region = "ap-northeast-1"
  }
}
```
