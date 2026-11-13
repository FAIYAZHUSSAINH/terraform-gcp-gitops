module "storage" {
  source = "git::https://github.com/FAIYAZHUSSAINH/terraform-gcp-modules.git//storage?ref=v1.0.0"
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


module "demo_storage" {
  source = "git::https://github.com/FAIYAZHUSSAINH/terraform-gcp-modules.git//storage?ref=v1.0.0"

  bucket_name = "fh-atlantis-demo-20261113-1683"
  region      = "asia-south1"
}
