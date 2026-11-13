module "storage" {
  source = "../../modules/storage"

  bucket_name = var.bucket_name
  region      = var.region
}


resource "google_storage_bucket" "automation_test" {
  name                        = "gitops-autoplan-test-fh-20261113"
  location                    = "ASIA-SOUTH1"
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"
  force_destroy               = false

  labels = {
    purpose = "atlantis-automation-test"
    managed = "terraform"
  }
}
