
resource "aws_lambda_function" "lambda_from_s3" {
  function_name = "lambda-from-s3"
  role          = "arn:aws:iam::271515947566:role/lambda-rds"
  handler       = "lambdas3_function.lambda_handler"      # depends on your code
  runtime       = "python3.10"
  s3_bucket        = "terra-lambda123"       # 👈 Change this
  s3_key           = "lambdas3_function.zip"         # 👈 Your ZIP path in S3
  source_code_hash = filebase64sha256("lambdas3_function.zip") # 👈 Local copy of same ZIP file
  timeout          = 10
  memory_size      = 128
}


