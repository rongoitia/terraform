output "codedepipeline_frontend_name" {
  value       = aws_codepipeline.codepipeline_frontend.name
}

output "codedepipeline_backend_name" {
  value       = aws_codepipeline.codepipeline_backend.name
}

# output "codedepipeline_matching_name" {
#   value       = aws_codepipeline.codepipeline_matching.name
# }

output "codedepipeline_odoo_name" {
  value       = aws_codepipeline.codepipeline_odoo.name
}

