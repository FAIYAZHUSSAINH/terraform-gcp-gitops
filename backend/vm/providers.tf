terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone

  impersonate_service_account = "internship-deployer-sa@terraform-gcs-gitops.iam.gserviceaccount.com"
}
