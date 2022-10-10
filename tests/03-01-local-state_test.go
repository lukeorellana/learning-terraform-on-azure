package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

// A test for module 3 section 1 local state
func Test03State01LocalStateTerraform(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{

		// The path to where our Terraform code is located
		TerraformDir: "../03-terraform-state/01-local-state",
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApplyAndIdempotent(t, terraformOptions)
}
