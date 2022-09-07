output "name" {
  description = "Nome gerado de acordo com o padrão"
  value       = local.name
}

output "tags" {
  description = "Representa todas as tags requeridas e com as tags adicionais"
  value       = local.tags
}
