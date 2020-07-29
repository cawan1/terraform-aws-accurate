output "aws_lambda_function_start" {
    value = var.schedule_start == true ? aws_lambda_function.start[0].arn  : 0 
}
output "aws_lambda_function_stop" {
    value = var.schedule_stop == true ? aws_lambda_function.stop[0].arn : 0
}