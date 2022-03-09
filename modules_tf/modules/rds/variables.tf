### RDS variables.

### Uncomment when you need to launch an RDS from a backup
variable "snapshot_identifier" {
  description = "Latest RDS backup"
}

variable "identifier" {
  description = "Set the name for the RDS"
}

variable "allocated_storage" {
  description = "Set the size of the disk"
}

variable "storage_type" {
   description = "Set storage type"
}

variable "engine" {
   description = "Set the Postgres engine"
}

variable "engine_version" {
   description = "Set Postgres version"
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
}


variable "db_name" {
   description = "set a Database name"
}

variable "db_username" {
   description = "Set a username for the RDS"
}

variable "db_password" {
   description = "Set a Password for the RDS"
}

variable "publicly_accessible" {
   description = "Set a Password for the RDS"
}

variable "maintenance_window" {
   description = "Set maintenance window"
}

variable "skip_final_snapshot" {
   description = "Keeps a backup in case the RDS is deleted"
}

variable "snapshot_identifies" {
   description = "Snapshot identifier"
}

variable "backup_retention_period" {
   description = "Holds the backup for X number of days"
}

variable "max_allocated_storage" {
   description = "Max Storage allowcated"
}

variable "backup_window" {
   description = "Set the backup window"
}

# variable "availability_zone" {
#    description = "Set the AZ"
# }

variable "storage_encrypted" {
   description = "Encrypt the storage"
}

variable "db_subnet_group_list" {
   description = "Set the list of the subnets"
}

variable "family_parameter_group" {
   description = "Set the name of the subnet group"
}

variable "multi_az" {
   description = "Set the multiaz value"
}


variable "environment" {
   description = "Set environment name"
}

variable "app_name" {
   description = "Set app name"
}

variable "security_group_id" {
   description = "Set the id of the security group for db"
}

