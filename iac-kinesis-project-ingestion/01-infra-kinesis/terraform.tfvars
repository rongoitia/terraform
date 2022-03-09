#Globals
aws_region = "us-east-1"
#aws_account = ""
environment = "sandbox"

# KINESIS DATA STREAM
data_stream_name = "poc_kinesis-project_kinesis_firehose_log_ms_1"

# KINESIS DELIVERY STREAM

kinesis_firehose_delivery_stream_name   = "poc_kinesis-project_kinesis_firehose_delivery_stream"
kinesis_firehose_stream_backup_prefix   = "backup/"
root_path                               = false
bucket_name                             = "poc-kinesis-project-bucket-para-gcp"
lambda_function_name                    = "transformar_data"
lambda_function_file_name               = "kinesis-firehose-cloudwatch-logs-json-processor-python"
glue_catalog_database_name              = "kinesis-project_glue_db"
glue_catalog_table_name                 = "kinesis-project_glue_tbl"
cloudwatch_subscription_filter_name     = "kinesis-project_cloudwatch_subscription"
cloudwatch_log_group_name               = "/aws/eks/switch-catalogo/cluster"
cloudwatch_filter_pattern               = "[version, account, eni, source, destination, srcport, destport, protocol, packets, bytes, windowstart, windowend, action, flowlogstatus]"