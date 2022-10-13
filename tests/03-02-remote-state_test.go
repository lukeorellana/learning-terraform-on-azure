package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

// A test for module 3 section 1 local state
func Test03State02RemoteStateTerraform(t *testing.T) {
	t.Parallel()

	// Terraform options for creating the Storage Account for Backend State
	tfCreateStorageOptions := &terraform.Options{

		// The path to where our Terraform code is located
		TerraformDir: "../03-terraform-state/02-remote-state/create-storage",
	}

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, tfCreateStorageOptions)

	// Run `terraform output` to get the values of output variables
	storageAccountName := terraform.Output(t, tfCreateStorageOptions, "storage_account_name")

	// Terraform options for creating the main configuration
	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../03-terraform-state/02-remote-state",
		BackendConfig: map[string]interface{}{
			"storage_account_name": storageAccountName,
		},
	}
	terraform.InitAndApplyAndIdempotent(t, terraformOptions)

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, tfCreateStorageOptions)
	defer terraform.Destroy(t, terraformOptions)
}
