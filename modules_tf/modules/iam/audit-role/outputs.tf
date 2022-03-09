

output "audit_role_name" {
  value       = aws_iam_role.audit_role.name
}

output "audit_role_arn" {
  value       = aws_iam_role.audit_role.arn
}
