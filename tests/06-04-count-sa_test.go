package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"strings"
)

// A test for module 5 section 4 challenge
func Test06AdvancedHCL04CountSATerraform(t *testing.T) {
	t.Parallel()

	// Randomize System Name
	rndName := strings.ToLower(random.UniqueId())

	// Terraform options for creating the main configuration
	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../06-advanced-hcl/04-count/storageaccount",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"name": rndName,
		},
	}

	terraform.InitAndApplyAndIdempotent(t, terraformOptions)

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)
}
