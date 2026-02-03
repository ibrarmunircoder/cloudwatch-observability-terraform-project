
resource "random_id" "suffix" {
  byte_length = 4
}

locals {
  bucket_prefix         = "${var.project_name}-${var.environment}"
  upload_bucket_name    = "${local.bucket_prefix}-upload-${random_id.suffix.hex}"
  processed_bucket_name = "${local.bucket_prefix}-processed-${random_id.suffix.hex}"
  lambda_function_name  = "${var.project_name}-${var.environment}-processor"

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    CreatedDate = timestamp()
  }
}



module "sns_notifications" {
  source = "../sns-notifications"

  project_name            = var.project_name
  environment             = var.environment
  critical_alert_email    = var.alert_email
  performance_alert_email = var.alert_email
  log_alert_email         = var.alert_email

  tags = local.common_tags
}

module "s3_buckets" {
  source = "../bucket"

  upload_bucket_name    = local.upload_bucket_name
  processed_bucket_name = local.processed_bucket_name
  environment           = var.environment
  enable_versioning     = var.enable_versioning

  tags = local.common_tags
}



module "lambda_function" {
  source = "../lambda-function"

  function_name    = local.lambda_function_name
  timeout          = var.lambda_timeout
  memory_size      = var.lambda_memory_size
  project_name = var.project_name

  # Use actual bucket ARNs from S3 module
  upload_bucket_arn    = module.s3_buckets.upload_bucket_arn
  upload_bucket_id     = module.s3_buckets.upload_bucket_id
  processed_bucket_arn = module.s3_buckets.processed_bucket_arn
  processed_bucket_id  = module.s3_buckets.processed_bucket_id

  aws_region         = var.aws_region
  log_retention_days = var.log_retention_days
  log_level          = var.log_level

  tags = local.common_tags
}


module "cloudwatch_metrics" {
  source = "../cloudwatch-metrics"

  function_name    = module.lambda_function.function_name
  log_group_name   = module.lambda_function.log_group_name
  metric_namespace = var.metric_namespace
  aws_region       = var.aws_region
  enable_dashboard = var.enable_dashboard

  tags = local.common_tags
}


module "cloudwatch_alarms" {
  source = "../cloudwatch-alarms"

  function_name                = module.lambda_function.function_name
  critical_alerts_topic_arn    = module.sns_notifications.critical_alerts_topic_arn
  performance_alerts_topic_arn = module.sns_notifications.performance_alerts_topic_arn
  metric_namespace             = var.metric_namespace

  # Alarm thresholds
  error_threshold                 = var.error_threshold
  duration_threshold_ms           = var.duration_threshold_ms
  throttle_threshold              = var.throttle_threshold
  concurrent_executions_threshold = var.concurrent_executions_threshold
  log_error_threshold             = var.log_error_threshold
  enable_no_invocation_alarm      = var.enable_no_invocation_alarm

  tags = local.common_tags
}
