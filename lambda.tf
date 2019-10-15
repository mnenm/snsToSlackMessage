data "archive_file" "slack_message_function" {
  type        = "zip"
  source_dir  = "lambda/slack_message"
  output_path = "lambda/bin/slack_message.zip"
}

resource "aws_lambda_permission" "sns" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.send-message-to-slack.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.slack-message-topic.arn
}

resource "aws_lambda_function" "send-message-to-slack" {
  filename         = data.archive_file.slack_message_function.output_path
  source_code_hash = data.archive_file.slack_message_function.output_base64sha256
  function_name    = "slack_message"
  handler          = "slack_message.handler"
  role             = aws_iam_role.lambda-for-slack-message.arn

  runtime     = "nodejs10.x"
  timeout     = 30
  memory_size = 128

  environment {
    variables = {
      SLACK_WEBHOOK_URI = var.slack_webhook_uri
    }
  }
}
