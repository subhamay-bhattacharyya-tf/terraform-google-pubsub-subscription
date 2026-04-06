module "pubsub_subscription" {
  source = "../../"

  environment  = var.environment
  project_code = var.project_code
  region       = var.region

  pubsub_subscription_config = {
    base_name = var.base_name
    topic     = var.topic
    dead_letter_policy = {
      dead_letter_topic     = var.dead_letter_topic
      max_delivery_attempts = var.max_delivery_attempts
    }
  }
}
