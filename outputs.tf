# =============================================================================
# Pub/Sub Subscription Module - Outputs
# =============================================================================

output "subscription_id" {
  description = "The fully-qualified ID of the Pub/Sub subscription."
  value       = google_pubsub_subscription.this.id
}

output "subscription_name" {
  description = "The name of the Pub/Sub subscription."
  value       = google_pubsub_subscription.this.name
}
