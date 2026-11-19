# Google Cloud provider
provider "google" {
  project = var.project_id
  region  = var.region
}

# 1. Create application service account
module "app_sa" {
  source = "git::https://github.com/FAIYAZHUSSAINH/terraform-gcp-modules.git//service-account?ref=53b9401fbe930cba5ebf6fe885a8e8f87dbc8045"

  project_id   = var.project_id
  account_id   = "internship-app-sa"
  display_name = "Internship Application SA"
}

# 2. Create deployment service account
module "deployer_sa" {
  source = "git::https://github.com/FAIYAZHUSSAINH/terraform-gcp-modules.git//service-account?ref=53b9401fbe930cba5ebf6fe885a8e8f87dbc8045"

  project_id   = var.project_id
  account_id   = "internship-deployer-sa"
  display_name = "Internship Deployer SA"
}

# 3. Assign permissions to the service accounts
module "iam_permissions" {
  source = "git::https://github.com/FAIYAZHUSSAINH/terraform-gcp-modules.git//iam?ref=53b9401fbe930cba5ebf6fe885a8e8f87dbc8045"

  project_id = var.project_id

  # Project-level IAM permission
  project_grants = {
    logging = {
      role   = "roles/logging.logWriter"
      member = "serviceAccount:${module.app_sa.email}"
    }
  }

  # Bucket-level IAM permission
  bucket_grants = {
    read_data = {
      bucket = var.bucket_name
      role   = "roles/storage.objectViewer"
      member = "serviceAccount:${module.app_sa.email}"
    }
  }

  # Service-account-level IAM permission
  service_account_grants = {
    deployer_act_as = {
      service_account_id = module.app_sa.name
      role               = "roles/iam.serviceAccountUser"
      member             = "serviceAccount:${module.deployer_sa.email}"
    }
  }
}
