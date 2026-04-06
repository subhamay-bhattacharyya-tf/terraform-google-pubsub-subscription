module "pubsub_subscription" {
  source = "../../"

  environment  = var.environment
  project_code = var.project_code
  region       = var.region

  pubsub_subscription_config = {
    base_name               = var.base_name
    topic                   = var.topic
    enable_message_ordering = true
  }
}
