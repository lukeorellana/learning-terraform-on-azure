package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"strings"
)

// A test for module 3 section 1 local state
func Test04State02DeployVariablesTerraform(t *testing.T) {
	t.Parallel()

	// Randomize System Name
	rndName := strings.ToLower(random.UniqueId())

	terraformOptions := &terraform.Options{

		// The path to where our Terraform code is located
		TerraformDir: "../04-variables/02-deployvariables",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"name": rndName,
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApplyAndIdempotent(t, terraformOptions)
}
