package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

// A test for module 2 secion 1 init plan apply destroy
func Test02Intro02InterpolationTerraform(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{

		// The path to where our Terraform code is located
		TerraformDir: "../02-init-plan-apply-destroy/02-interpolation",
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApplyAndIdempotent(t, terraformOptions)
}
