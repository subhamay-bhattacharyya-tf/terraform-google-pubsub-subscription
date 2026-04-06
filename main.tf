# =============================================================================
# Pub/Sub Subscription Module - Main
# Creates and manages a Google Cloud Pub/Sub subscription.
# =============================================================================

resource "google_pubsub_subscription" "this" {
  name  = local.subscription_name
  topic = var.pubsub_subscription_config.topic

  ack_deadline_seconds       = var.pubsub_subscription_config.ack_deadline_seconds
  message_retention_duration = var.pubsub_subscription_config.message_retention_duration
  retain_acked_messages      = var.pubsub_subscription_config.retain_acked_messages
  filter                     = var.pubsub_subscription_config.filter
  enable_message_ordering    = var.pubsub_subscription_config.enable_message_ordering

  labels = merge(
    var.pubsub_subscription_config.labels,
    {
      environment  = var.environment
      project_code = var.project_code
    }
  )

  dynamic "dead_letter_policy" {
    for_each = var.pubsub_subscription_config.dead_letter_policy != null ? [var.pubsub_subscription_config.dead_letter_policy] : []
    content {
      dead_letter_topic     = dead_letter_policy.value.dead_letter_topic
      max_delivery_attempts = dead_letter_policy.value.max_delivery_attempts
    }
  }

  dynamic "expiration_policy" {
    for_each = var.pubsub_subscription_config.expiration_policy != null ? [var.pubsub_subscription_config.expiration_policy] : []
    content {
      ttl = expiration_policy.value.ttl
    }
  }
}
