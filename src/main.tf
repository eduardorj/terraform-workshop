terraform {
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
      version = ">= 1.12.0"
    }
  }
}

# Configure the IBM Provider
provider "ibm" {
  region = "us-south"
}

# Create a VPC
resource "ibm_is_vpc" "testacc_vpc" {
  name = "test-vpc"
}
