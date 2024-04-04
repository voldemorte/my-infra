# AWS Infrastructure Management with Terragrunt

This repository contains infrastructure as code (IaC) for managing AWS resources using Terragrunt. The structure of this repository is designed to manage infrastructure for various applications and their associated PagerDuty notification configurations.

## Overview

The repository structure is organized as follows:

- `applications/`: Contains configurations for various applications belonging to the org.
  - `teamA/`: Configuration specific to Team A owned applications.
    - `dummy_app/`: Configuration for the Dummy App.
      - `component/`: Components of the Dummy App.
        - `sqs/`: Configuration for SQS.
          - `terragrunt.hcl`: Terragrunt configuration for SQS.

- `notifications/`: Contains configurations for PagerDuty notifications.
  - `teamA/`: Holds pagerduty groups and schedules specific to Team A.
    - `terragrunt.hcl`: Terragrunt configuration for Team A's PagerDuty notifications.

- `terragrunt.hcl`: Root Terragrunt configuration file, this file defines the cloud authentication mechanisms.

### PagerDuty Notifications

The `notifications/` directory is dedicated to managing PagerDuty notification configurations for different teams. Each team's configuration is stored within its respective directory. These configurations define the PagerDuty escalation policies and other relevant settings for handling infrastructure alerts.

### Applications Infrastructure

The `applications/` directory hosts infrastructure components required for individual applications. Each application may have its own set of components managed within its directory. These components are designed as custom modules, often combining open-source modules like AWS SQS and CloudWatch Metric Alarm.

- **Custom Modules:** Each component, such as SQS, is a custom module crafted by combining open-source modules to suit specific application requirements. Individual resource metric alarms are defined within these components. These alarms are unique to each component but share a common AWS SNS topic. When an alarm is triggered, it publishes the alert to this shared SNS topic.

- **PagerDuty Integration:** Alerts published to the shared SNS topic are routed to PagerDuty escalation policies defined in the `notifications/` directory. This setup ensures that alerts are appropriately handled by the designated PagerDuty teams.

### Set Up AWS Assume Role Policy
In the terragrunt.hcl file at the root of the repository, ensure that the AWS Assume Role policy is properly configured. This policy restricts the IAM privileges required to execute the Terraform code. The role defined in this policy should not be assumable by any human user and can only be assumed by the runner executing the Github action within the AWS environment.

#### Future enhancements
- Add GithubCI actions to perform the plan stage that can show the changes that are being made to this repo before one can apply these changes.

- Define [CodeOwners](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners) so that application owners can approve the changes relevant to their section before merging and applying.
