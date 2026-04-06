package test

import (
	"fmt"
	"strings"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/require"
)

// TestPubSubSubscriptionBasic tests creating a basic Pub/Sub subscription.
func TestPubSubSubscriptionBasic(t *testing.T) {
	t.Parallel()

	retrySleep := 5 * time.Second
	unique := strings.ToLower(random.UniqueId())
	baseName := fmt.Sprintf("tt-sub-%s", unique)
	projectID := mustEnv(t, "GOOGLE_CLOUD_PROJECT")
	topicID := mustEnv(t, "GOOGLE_PUBSUB_TOPIC")

	tfOptions := &terraform.Options{
		TerraformDir: "..",
		NoColor:      true,
		Vars: map[string]interface{}{
			"environment":  "devl",
			"project_code": "tt",
			"region":       "us-central1",
			"pubsub_subscription_config": map[string]interface{}{
				"base_name": baseName,
				"topic":     fmt.Sprintf("projects/%s/topics/%s", projectID, topicID),
				"location":  "us-central1",
			},
		},
	}

	defer terraform.Destroy(t, tfOptions)
	terraform.InitAndApply(t, tfOptions)

	time.Sleep(retrySleep)

	expectedName := fmt.Sprintf("tt-%s-us-central1-devl", baseName)
	outputName := terraform.Output(t, tfOptions, "subscription_name")
	require.Equal(t, expectedName, outputName)

	outputID := terraform.Output(t, tfOptions, "subscription_id")
	require.Contains(t, outputID, baseName)
}
