


module "dev" {
  source = "./modules/environment"

  project_name      = var.project_name
  environment       = "dev"
  alert_email       = var.alert_email
  enable_versioning = var.enable_s3_versioning
  concurrent_executions_threshold = var.concurrent_executions_threshold

  lambda_timeout     = var.lambda_timeout
  lambda_memory_size = var.lambda_memory_size

  aws_region         = var.aws_region
  log_retention_days = var.log_retention_days
  log_level          = var.log_level

  enable_dashboard =  var.enable_cloudwatch_dashboard
  metric_namespace = var.metric_namespace
}