output "aws_lambda_function_start" {
    value = aws_lambda_function.start[0].arn
}

output "aws_lambda_function_stop" {
    value = aws_lambda_function.stop[0].arn
}