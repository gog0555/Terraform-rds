resource "aws_sns_topic" "rds_topic" {
  name = "${var.env}-${var.name}-rds-events"
}

resource "aws_db_event_subscription" "example" {
  name            = "example-event-subscription"
  source_type     = "db-instance"
  source_ids      = [var.rds_identifier]
  event_categories = ["failover"]

  sns_topic = aws_sns_topic.rds_topic.arn
}

resource "aws_lambda_function" "example" {
  filename      = "code/lambda_function.zip"
  function_name = "example-lambda-function"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"
}

# Lambda関数のIAMロールの作成
resource "aws_iam_role" "lambda_exec" {
  name = "lambda-exec-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

# Lambda関数へのポリシーアタッチ
resource "aws_iam_policy_attachment" "lambda_attachment" {
  name       = "lambda-exec-policy-attachment"
  policy_arn = aws_iam_policy.lambda_policy.arn
  roles      = [aws_iam_role.lambda_exec.name]
}

resource "aws_iam_policy_attachment" "lambda_basic_execution_attachment" {
  name       = "lambda-basic-execution-attachment"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  roles      = [aws_iam_role.lambda_exec.name]
}

# Lambda関数に必要なポリシーの作成
resource "aws_iam_policy" "lambda_policy" {
  name        = "lambda-exec-policy"
  description = "Policy for RDS failover handling lambda function"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "rds:PromoteReadReplica"
        ],
        Effect   = "Allow",
        Resource = var.replica_arn
      }
    ]
  })
}
