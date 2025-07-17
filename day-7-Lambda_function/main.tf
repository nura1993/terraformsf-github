
# Lambda Function
resource "aws_lambda_function" "example" {
  function_name = "my-lambda"
  role          =  "arn:aws:iam::271515947566:role/lambda-rds"
  handler       = "lambda_function.lambda_handler"  # file.function
  runtime       = "python3.10"
  filename      = "lambda_function.zip"
  source_code_hash = filebase64sha256("lambda_function.zip")
}

