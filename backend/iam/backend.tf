terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.0"
    }
  }

  backend "gcs" {
    bucket = "terraform-bucket-is-mine"
    prefix = "gitops/dev/iam"
  }
}
