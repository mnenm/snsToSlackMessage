resource "aws_iam_role" "lambda-for-slack-message" {
  name               = "sendSlackMessageRole"
  assume_role_policy = file("iam_policies/lambda-assume-role.json")

  tags = {
    Name = "sendSlackMessageRole"
  }
}

resource "aws_iam_role_policy_attachment" "lambda-basic-execution-role" {
  role       = aws_iam_role.lambda-for-slack-message.name
  policy_arn = local.iamrole.lambda_basic_role_arn
}
