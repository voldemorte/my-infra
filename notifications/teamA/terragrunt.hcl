include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "https://github.com/voldemorte/aws-notify.git?ref=master"
}

inputs = {
  sns_topic_name = "dummy-topic"
  pd_escalation_policy_id = "some_escalation_policy_id"
}
