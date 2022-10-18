package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

// A test for module 5 section 4 challenge
func Test06AdvancedHCL06ForEachForTerraform(t *testing.T) {
	t.Parallel()

	// Terraform options for creating the main configuration
	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../06-advanced-hcl/06-for-each-with-for",
	}

	terraform.InitAndApplyAndIdempotent(t, terraformOptions)

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)
}
