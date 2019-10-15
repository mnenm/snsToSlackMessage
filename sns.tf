resource "aws_sns_topic" "slack-message-topic" {
  name = "slack-message-topic"
}

resource "aws_sns_topic_subscription" "lambda" {
  topic_arn = aws_sns_topic.slack-message-topic.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.send-message-to-slack.arn
}
