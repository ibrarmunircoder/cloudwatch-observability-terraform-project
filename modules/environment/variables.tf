variable "project_name" {
  description = "Project name for resource naming"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "alert_email" {
  description = "Email address for critical alerts (errors, failures)"
  type        = string
  default     = "ibrarmunir009@gmail.com"
}


variable "enable_versioning" {
  description = "Enable versioning on S3 buckets"
  type        = bool
  default     = true
}


variable "lambda_timeout" {
  description = "Lambda function timeout in seconds"
  type        = number
  default     = 60
}

variable "lambda_memory_size" {
  description = "Lambda function memory size in MB"
  type        = number
  default     = 1024
}



variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "log_retention_days" {
  description = "CloudWatch log retention in days"
  type        = number
  default     = 7
}

variable "log_level" {
  description = "Log level for Lambda function (DEBUG, INFO, WARNING, ERROR)"
  type        = string
  default     = "INFO"
}


variable "metric_namespace" {
  description = "CloudWatch custom metrics namespace"
  type        = string
  default     = "ImageProcessor/Lambda"
}

variable "enable_dashboard" {
  description = "Enable CloudWatch dashboard creation"
  type        = bool
  default     = true
}

variable "error_threshold" {
  description = "Number of errors to trigger alarm"
  type        = number
  default     = 3
}

variable "duration_threshold_ms" {
  description = "Duration threshold in milliseconds"
  type        = number
  default     = 45000 # 45 seconds (75% of 60s timeout)
}

# Throttle Alarm Configuration
variable "throttle_threshold" {
  description = "Number of throttles to trigger alarm"
  type        = number
  default     = 5
}

variable "concurrent_executions_threshold" {
  description = "Concurrent executions threshold"
  type        = number
}

# Log Error Threshold
variable "log_error_threshold" {
  description = "Number of log errors to trigger alarm"
  type        = number
  default     = 1
}

# Optional Alarms
variable "enable_no_invocation_alarm" {
  description = "Enable alarm for no invocations"
  type        = bool
  default     = false
}
