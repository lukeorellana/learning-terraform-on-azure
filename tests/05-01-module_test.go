package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

// A test for module 3 section 1 local state
func Test05Module01ModuleTerraform(t *testing.T) {
	t.Parallel()

	// Terraform options for creating the main configuration
	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../05-modules/01-module/",
	}

	terraform.InitAndApplyAndIdempotent(t, terraformOptions)

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)
}
