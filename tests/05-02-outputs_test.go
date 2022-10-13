package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

// A test for module 5 section 2 outputs
func Test05Module02OutputsTerraform(t *testing.T) {
	t.Parallel()

	// Terraform options for creating the main configuration
	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../05-modules/02-outputs/",
	}

	terraform.InitAndApplyAndIdempotent(t, terraformOptions)

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)
}
