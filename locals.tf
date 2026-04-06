# =============================================================================
# Pub/Sub Subscription Module - Locals
# =============================================================================

locals {
  subscription_name = "${var.project_code}-${var.pubsub_subscription_config.base_name}-${var.pubsub_subscription_config.location}-${var.environment}"
}
