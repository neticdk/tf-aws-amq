/*
 * Copyright (c) 2019 Netic A/S. All rights reserved.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

locals {
  password = length(var.password) > 0 ? var.password : random_string.password.result

  tags = {
    Terraform = "true"
  }
}

resource "random_string" "password" {
  length  = 16
  special = false
}

resource "aws_mq_broker" "this" {
  apply_immediately          = true
  auto_minor_version_upgrade = true
  broker_name                = var.broker_name

  configuration {
    id       = aws_mq_configuration.this.id
    revision = aws_mq_configuration.this.latest_revision
  }

  deployment_mode     = var.deployment_mode
  engine_type         = "ActiveMQ"
  engine_version      = var.engine_version
  host_instance_type  = var.host_instance_type
  publicly_accessible = false
  security_groups     = var.security_groups
  subnet_ids          = var.subnet_ids

  /* NOTE: AWS currently does not support updating the maintenance window beyond resource creation
  maintenance_window_start_time {
    day_of_week = var.maintenance_window_start_time_day_of_week
    time_of_day = var.maintenance_window_start_time_time_of_day
    time_zone   = var.maintenance_window_start_time_time_zone
  }
  */

  logs {
    general = var.logs_general
    audit   = var.logs_audit
  }

  user {
    username       = var.username
    password       = local.password
    groups         = ["admin"]
    console_access = true
  }

  tags = merge(var.tags, local.tags)

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_mq_configuration" "this" {
  description    = "ActiveMQ Configuration"
  name           = var.broker_name
  engine_type    = "ActiveMQ"
  engine_version = var.engine_version
  data           = var.configuration_data
}

