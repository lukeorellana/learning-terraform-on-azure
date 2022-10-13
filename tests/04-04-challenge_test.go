package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"strings"
)

// A test for module 3 section 1 local state
func Test04State04ChallengeTerraform(t *testing.T) {
	t.Parallel()

	// Randomize System Name
	rndName := strings.ToLower(random.UniqueId())

	// Terraform options for creating the Storage Account for Backend State
	tfCreateStorageOptions := &terraform.Options{

		// The path to where our Terraform code is located
		TerraformDir: "../04-variables/04-challenge/02-solution/create-storage",
	}

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, tfCreateStorageOptions)

	// Run `terraform output` to get the values of output variables
	storageAccountName := terraform.Output(t, tfCreateStorageOptions, "storage_account_name")

	// Terraform options for creating the main configuration
	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../04-variables/04-challenge/02-solution/",

		// Backend configuration using partial state
		BackendConfig: map[string]interface{}{
			"storage_account_name": storageAccountName,
		},

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"name":           rndName,
			"admin_password": "P@ssw0rdP@ssw0rd23",
		},
	}

	terraform.InitAndApplyAndIdempotent(t, terraformOptions)

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, tfCreateStorageOptions)
	defer terraform.Destroy(t, terraformOptions)
}
