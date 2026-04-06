module "pubsub_subscription" {
  source = "../../"

  environment  = var.environment
  project_code = var.project_code
  region       = var.region

  pubsub_subscription_config = {
    base_name                  = var.base_name
    topic                      = var.topic
    message_retention_duration = var.message_retention_duration
    retain_acked_messages      = var.retain_acked_messages
  }
}
