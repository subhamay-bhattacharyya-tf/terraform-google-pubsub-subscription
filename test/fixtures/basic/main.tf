resource "google_pubsub_topic" "test" {
  name    = var.topic_name
  project = var.project_id
}

module "pubsub_subscription" {
  source = "../../../"

  environment  = var.environment
  project_code = var.project_code

  pubsub_subscription_config = {
    base_name = var.base_name
    topic     = google_pubsub_topic.test.id
    location  = "us-central1"
  }
}
