variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
}

variable "timeout" {
  description = "Lambda function timeout in seconds"
  type        = number
  default     = 60
}

variable "memory_size" {
  description = "Lambda function memory size in MB"
  type        = number
  default     = 1024
}


variable "upload_bucket_arn" {
  description = "ARN of the upload S3 bucket"
  type        = string
}

variable "upload_bucket_id" {
  description = "ID of the upload S3 bucket"
  type        = string
}

variable "processed_bucket_arn" {
  description = "ARN of the processed S3 bucket"
  type        = string
}

variable "processed_bucket_id" {
  description = "ID of the processed S3 bucket"
  type        = string
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

variable "environment_variables" {
  description = "Additional environment variables for Lambda"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}