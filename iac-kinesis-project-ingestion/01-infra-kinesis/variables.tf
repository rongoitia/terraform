#Globals
variable aws_region { default = "sa-east-1" }
#variable aws_account { }
variable environment {}

#VPC
#variable azs { type = list}
#variable vpc_cidr { }
#variable cidr_public_blocks { type = list }
#variable cidr_private_blocks { type = list}
#variable cidr_private_db_blocks { type = list}

# KINESIS STREAM
variable data_stream_name {}

# KINESIS DELIVERY STREAM
variable "kinesis_firehose_delivery_stream_name" {
  description = "Name to be use on kinesis firehose delivery stream"
  type        = string
}

variable "kinesis_firehose_stream_backup_prefix" {
  description = "The prefix name to use for the kinesis backup"
  type        = string
  default     = "backup/"
}

variable "root_path" {
  description = "The path where the lambda function file is located is root or module path"
  type        = bool
  default     = false
}

variable "bucket_name" {
  description = "The bucket name"
  type        = string
}

variable "lambda_function_name" {
  description = "The lambda function name"
  type        = string
}

variable "lambda_function_file_name" {
  description = "The lambda function file name"
  type        = string
}

variable "glue_catalog_database_name" {
  description = "The Glue catalog database name"
  type        = string
}

variable "glue_catalog_table_name" {
  description = "The Glue catalog database table name"
  type        = string
}

variable "glue_catalog_table_columns" {
  description = "A list of table columns"
  #type        = map(object({
  #  name = string
  #  type = string
  #}))
  type = list(object({
    name     = string
    type     = string
  }))
  default = [
    {
      name = "HTML_ENTITY_DECODE"
      type                = "string"
    },
    {
      name = "URL_DECODE"
      type                = "string"
    }]
}

variable "cloudwatch_subscription_filter_name" {
  description = "The subscription filter name"
  type        = string
}

variable "cloudwatch_log_group_name" {
  description = "The cloudwatch log group name"
  type        = string
}

variable "cloudwatch_filter_pattern" {
  description = "The cloudwatch filter pattern"
  type        = string
}