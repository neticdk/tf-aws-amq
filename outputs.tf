/*
 * Copyright (c) 2019 Netic A/S. All rights reserved.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

output "activemq_url" {
  value = "failover:(${aws_mq_broker.this.instances[0].endpoints[1]},${aws_mq_broker.this.instances[1].endpoints[1]})"
}

output "openwire_url" {
  value = "failover:(${aws_mq_broker.this.instances[0].endpoints[0]},${aws_mq_broker.this.instances[1].endpoints[0]})"
}

output "primary_url" {
  value = aws_mq_broker.this.instances[0].endpoints[1]
}

output "secondary_url" {
  value = aws_mq_broker.this.instances[1].endpoints[1]
}

output "primary_console_url" {
  value = aws_mq_broker.this.instances[0].console_url
}

output "secondary_console_url" {
  value = aws_mq_broker.this.instances[1].console_url
}

output "primary_ip_address" {
  value = aws_mq_broker.this.instances[0].ip_address
}

output "secondary_ip_address" {
  value = aws_mq_broker.this.instances[1].ip_address
}

output "id" {
  value = aws_mq_broker.this.id
}

output "arn" {
  value = aws_mq_broker.this.arn
}

output "username" {
  value       = var.username
  description = "AmazonMQ admin username"
  sensitive   = true
}

output "password" {
  value       = local.password
  description = "AmazonMQ admin password"
  sensitive   = true
}

output "additional_users" {
  description = "AmazonMQ additional users credentials"
  value       = local.additional_users
  sensitive   = true
}
