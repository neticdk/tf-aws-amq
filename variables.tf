/*
 * Copyright (c) 2019 Netic A/S. All rights reserved.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}

variable "broker_name" {
  description = "Broker Name"
  type        = string
}

variable "engine_version" {
  description = "ActiveMQ Version"
  type        = string
  default     = "5.15.9"
}

variable "deployment_mode" {
  description = "Deployment Mode"
  default     = "ACTIVE_STANDBY_MULTI_AZ" // "SINGLE_INSTANCE"
}

variable "host_instance_type" {
  description = "EC2 Instance Type"
  default     = "mq.t2.micro"
}

variable "publicly_accessible" {
  description = "Whether to enable connections from applications outside of the VPC that hosts the broker's subnets"
  type        = bool
  default     = false
}

variable "security_groups" {
  description = "The list of security group IDs assigned to the broker"
  type        = list
  default     = []
}

variable "subnet_ids" {
  description = "The list of subnet IDs in which to launch the broker"
  default     = []
}

variable "maintenance_window_start_time_day_of_week" {
  description = "The day of the week"
  type        = string
  default     = "SUNDAY"
}

variable "maintenance_window_start_time_time_of_day" {
  description = "The time, in 24-hour format"
  type        = string
  default     = "02:00"
}

variable "maintenance_window_start_time_time_zone" {
  description = "The time zone, UTC by default, in either the Country/City format, or the UTC offset format"
  type        = string
  default     = "CET"
}

variable "logs_general" {
  description = "Enables general logging via CloudWatch"
  type        = bool
  default     = true
}

variable "logs_audit" {
  description = "Enables audit logging. User management action made using JMX or the ActiveMQ Web Console is logged"
  type        = bool
  default     = true
}

variable "additional_users" {
  description = "Additional AmazonMQ users"
  default     = null
  type = map(object({
    id             = number
    username       = string
    password       = string
    console_access = bool
    groups         = list(string)
  }))
}

variable "username" {
  description = "Username"
  type        = string
  default     = "admin"
}

variable "password" {
  description = "Password"
  type        = string
  default     = ""
}

variable "password_count" {
  description = "Number of passwords to generate for users. Must be at least the number of users."
  type        = number
  default     = 100
}

variable "configuration_data" {
  description = "The broker configuration in XML format"
  type        = string
  default     = null
}

variable "apply_immediately" {
  description = "Apply changes to broker immediately - might cause a reboot"
  type        = bool
  default     = false
}

variable "auto_minor_version_upgrade" {
  description = "Enables automatic upgrades to new minor versions for brokers, as Apache releases the versions."
  type        = bool
  default     = true
}

