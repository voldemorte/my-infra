include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "https://github.com/voldemorte/aws-sqs.git?ref=master"
}

dependency "team_notifications" {
  config_path = "path_relative_to_include()/notifications/teamA"
}

inputs = {
  name    = "dummy-sqs-resource"
  sns_arn = dependency.team_notifications.outputs.sns_topic_arn
}
