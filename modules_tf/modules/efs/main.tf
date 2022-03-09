resource "aws_efs_file_system" "efs_odoo" {
  creation_token = "odoo-efs"
  encrypted      = true

  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }

  tags = {
    Name = "odoo-efs"
  }
}

resource "aws_efs_access_point" "efs_ap" {
  file_system_id = aws_efs_file_system.efs_odoo.id

  tags = {
    Name = "odoo-efs"
  }
}

resource "aws_efs_mount_target" "efs_mt_a" {
  file_system_id = aws_efs_file_system.efs_odoo.id
  subnet_id      = var.subnet_id_a
}

resource "aws_efs_mount_target" "efs_mt_b" {
  file_system_id = aws_efs_file_system.efs_odoo.id
  subnet_id      = var.subnet_id_b
}

resource "aws_efs_mount_target" "efs_mt_c" {
  file_system_id = aws_efs_file_system.efs_odoo.id
  subnet_id      = var.subnet_id_c

}



# resource "aws_backup_vault" "efs_vault" {
#   name        = "efs_backup_vault"
#   #kms_key_arn = aws_kms_key.example.arn
# }

# resource "aws_backup_plan" "efs_plan" {
#   name = "efs_backup_plan"

#   rule {
#     rule_name         = "efs_backup_rule"
#     target_vault_name = aws_backup_vault.efs_vault.name
#     schedule          = "cron(0 5 ? * * *)"
#   }

#   advanced_backup_setting {
#     backup_options = {
#       WindowsVSS = "disabled"
#     }
#     resource_type = "EC2"
#   }
# }


# resource "aws_iam_role" "efs_role" {
#   name               = "${var.app_name}-${var.environment}-efs-backup-role"
#   assume_role_policy = <<POLICY
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": ["sts:AssumeRole"],
#       "Effect": "allow",
#       "Principal": {
#         "Service": ["backup.amazonaws.com"]
#       }
#     }
#   ]
# }
# POLICY
# }

# resource "aws_iam_role_policy_attachment" "efs_att" {
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
#   role       = aws_iam_role.efs_role.name
# }

# resource "aws_backup_selection" "efs_backup" {
#   iam_role_arn = aws_iam_role.efs_role.arn
#   name         = "${var.app_name}-${var.environment}-efs-backup"
#   plan_id      = aws_backup_plan.efs_plan.id

#   resources = [
#     aws_efs_file_system.efs_odoo.arn
#   ]
# }