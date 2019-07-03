# Netic AWS AMQ Module

## Supported Terraform Versions

Terraform 0.12

## Usage

```hcl
module "amq" {
  source  = "github.com/neticdk/tf-aws-amq"
}
```

<!---BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK--->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| broker\_name | Broker Name | string | n/a | yes |
| configuration\_data | The broker configuration in XML format | string | `"null"` | no |
| deployment\_mode | Deployment Mode | string | `"ACTIVE_STANDBY_MULTI_AZ"` | no |
| engine\_version | ActiveMQ Version | string | `"5.15.9"` | no |
| host\_instance\_type | EC2 Instance Type | string | `"mq.t2.micro"` | no |
| logs\_audit | Enables audit logging. User management action made using JMX or the ActiveMQ Web Console is logged | boolean | `"true"` | no |
| logs\_general | Enables general logging via CloudWatch | boolean | `"true"` | no |
| maintenance\_window\_start\_time\_day\_of\_week | The day of the week | string | `"SUNDAY"` | no |
| maintenance\_window\_start\_time\_time\_of\_day | The time, in 24-hour format | string | `"02:00"` | no |
| maintenance\_window\_start\_time\_time\_zone | The time zone, UTC by default, in either the Country/City format, or the UTC offset format | string | `"CET"` | no |
| password | Password | string | `""` | no |
| publicly\_accessible | Whether to enable connections from applications outside of the VPC that hosts the broker's subnets | boolean | `"false"` | no |
| security\_groups | The list of security group IDs assigned to the broker | list | `<list>` | no |
| subnet\_ids | The list of subnet IDs in which to launch the broker | list | `<list>` | no |
| tags | A map of tags to add to all resources | map | `<map>` | no |
| username | Username | string | `"admin"` | no |

## Outputs

| Name | Description |
|------|-------------|
| activemq\_url |  |
| arn |  |
| id |  |
| openwire\_url |  |
| password | AmazonMQ admin password |
| primary\_console\_url |  |
| primary\_ip\_address |  |
| primary\_url |  |
| secondary\_console\_url |  |
| secondary\_ip\_address |  |
| secondary\_url |  |
| username | AmazonMQ admin username |

<!---END OF PRE-COMMIT-TERRAFORM DOCS HOOK--->

# Copyright
Copyright (c) 2019 Netic A/S. All rights reserved.

# License
MIT Licened. See LICENSE for full details.

