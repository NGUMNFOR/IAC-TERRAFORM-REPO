
# Fetching for just ip addresses

output "public_ip" {
  description = "public ip2"
  value       = aws_instance.web[*].public_ip
  sensitive   = false

}

# Fetching for all ip addresses
output "public_ip2" {
  description = "public ip2"
  value       = [aws_instance.web[*].public_ip]
  sensitive   = false

}

output "public_ip3" {
  description = "public ip2"
  value       = slice(aws_instance.web[*].public_ip, 0, 2)
  sensitive   = false

}

# For loop with output

output "ec2_arn" {
  description = "public ip2"
  value       = [for arn in aws_instance.web: arn.arn]
  sensitive   = false

}


