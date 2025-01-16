terraform {
  required_version = "~> 1.3"

  required_providers {
    fortios = {
      source  = "fortinetdev/fortios"
      version = ">= 1.17.0"
    }
  }
}
