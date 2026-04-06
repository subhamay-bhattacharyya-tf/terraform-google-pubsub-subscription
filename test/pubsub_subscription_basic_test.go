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

// TestPubSubSubscriptionBasic creates a temporary topic and subscription, asserts
// outputs, then destroys both. No pre-existing topic is required.
func TestPubSubSubscriptionBasic(t *testing.T) {
	t.Parallel()

	unique := strings.ToLower(random.UniqueId())
	projectID := mustEnv(t, "GOOGLE_CLOUD_PROJECT")

	tfOptions := &terraform.Options{
		TerraformDir: "./fixtures/basic",
		NoColor:      true,
		Vars: map[string]interface{}{
			"project_id":   projectID,
			"environment":  "devl",
			"project_code": "tt",
			"base_name":    fmt.Sprintf("sub-%s", unique),
			"topic_name":   fmt.Sprintf("tt-topic-%s", unique),
		},
	}

	defer terraform.Destroy(t, tfOptions)
	terraform.InitAndApply(t, tfOptions)

	time.Sleep(5 * time.Second)

	expectedName := fmt.Sprintf("tt-sub-%s-us-central1-devl", unique)
	outputName := terraform.Output(t, tfOptions, "subscription_name")
	require.Equal(t, expectedName, outputName)

	outputID := terraform.Output(t, tfOptions, "subscription_id")
	require.Contains(t, outputID, unique)
}
