/*
 * Copyright (c) 2019 Netic A/S. All rights reserved.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

locals {
  password = length(var.password) > 0 ? var.password : random_string.password.result

  additional_users = var.additional_users == null ? [] : [for u in var.additional_users : {
    id             = u.id
    username       = u.username
    password       = length(u.password) > 0 ? u.password : random_password.additional_user_password[u.id].result
    groups         = u.groups
    console_access = u.console_access
  }]
  password_count = var.additional_users == null ? 0 : element(sort([for x in values(var.additional_users) : x.id]), length(values(var.additional_users)) - 1) + 1

  tags = {
    Terraform = "true"
  }
}

resource "random_string" "password" {
  length  = 16
  special = false
}

resource "random_password" "additional_user_password" {
  count   = local.password_count
  length  = 16
  special = false
}

resource "aws_mq_broker" "this" {
  apply_immediately          = var.apply_immediately
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

  dynamic user {
    for_each = local.additional_users == null ? [] : [for u in local.additional_users : {
      username       = u.username
      password       = u.password
      groups         = u.groups
      console_access = u.console_access
    }]

    content {
      username       = user.value.username
      password       = user.value.password
      groups         = user.value.groups
      console_access = user.value.console_access
    }
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


data "aws_iam_policy_document" "amazonmq_log_publishing_policy" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:PutLogEventsBatch",
    ]

    resources = ["arn:aws:logs:*:*:log-group:/aws/amazonmq/*"]

    principals {
      identifiers = ["mq.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_cloudwatch_log_resource_policy" "amazonmq_log_publishing_policy" {
  policy_document = "${data.aws_iam_policy_document.amazonmq_log_publishing_policy.json}"
  policy_name     = "amazonmq-log-publishing-policy"
}
