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

# 3. Create Atlantis runner service account
module "atlantis_runner_sa" {
  source = "git::https://github.com/FAIYAZHUSSAINH/terraform-gcp-modules.git//service-account?ref=53b9401fbe930cba5ebf6fe885a8e8f87dbc8045"

  project_id   = var.project_id
  account_id   = "atlantis-runner-sa"
  display_name = "Atlantis Runner Service Account"
}

# 4. Assign IAM permissions
module "iam_permissions" {
  source = "git::https://github.com/FAIYAZHUSSAINH/terraform-gcp-modules.git//iam?ref=53b9401fbe930cba5ebf6fe885a8e8f87dbc8045"

  project_id = var.project_id

  # Project-level permissions
  project_grants = {
    logging = {
      role   = "roles/logging.logWriter"
      member = "serviceAccount:${module.app_sa.email}"
    }
  }

  # Bucket-level permissions
  bucket_grants = {
    read_data = {
      bucket = var.bucket_name
      role   = "roles/storage.objectViewer"
      member = "serviceAccount:${module.app_sa.email}"
    }
  }

  # Service-account-level permissions
  service_account_grants = {
    deployer_act_as = {
      service_account_id = module.app_sa.name
      role               = "roles/iam.serviceAccountUser"
      member             = "serviceAccount:${module.deployer_sa.email}"
    }

    atlantis_impersonates_deployer = {
      service_account_id = module.deployer_sa.name
      role               = "roles/iam.serviceAccountTokenCreator"
      member             = "serviceAccount:${module.atlantis_runner_sa.email}"
    }
  }
}

# Additional permissions for infrastructure deployment
module "deployment_access" {
  source = "git::https://github.com/FAIYAZHUSSAINH/terraform-gcp-modules.git//iam?ref=53b9401fbe930cba5ebf6fe885a8e8f87dbc8045"

  project_id = var.project_id

  project_grants = {
    for key, role in var.deployer_project_roles :
    "deployer_${key}" => {
      role   = role
      member = "serviceAccount:${module.deployer_sa.email}"
    }
  }

  bucket_grants = {
    atlantis_state = {
      bucket = var.terraform_state_bucket
      role   = "roles/storage.objectAdmin"
      member = "serviceAccount:${module.atlantis_runner_sa.email}"
    }
  }
}
