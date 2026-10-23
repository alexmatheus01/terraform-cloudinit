# Exibe o ID da VM
output "instance_id" {
  description = "ID da instância Linux"
  value       = aws_instance.vm_linux.id
}

# Exibe o endereco IP público da VM
output "public_ip" {
  description = "Endereco IP público da instância"
  value       = aws_instance.vm_linux.public_ip
}