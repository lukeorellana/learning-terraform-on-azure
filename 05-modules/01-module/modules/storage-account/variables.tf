variable "storage_account_name" {
    type = string
    description = "Name of storage account"
}
variable "resource_group_name" {
    type = string
    description = "Name of resource group"
}
variable "location" {
    type = string
    description = "Azure location of storage account environment"
    default = "westus2"
}
