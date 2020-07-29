output "scheduler_lambda_start" {
  description = "Lambda function trigged by cloudwatch to stop RDS Instance"
  value = module.scheduler.aws_lambda_function_start
}

output "scheduler_lambda_stop" {
  description = "Lambda function trigged by cloudwatch to start RDS Instance"
  value = module.scheduler.aws_lambda_function_stop
}
