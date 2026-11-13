terraform {
  backend "gcs" {
    bucket = "terraform-bucket-is-mine"
    prefix = "gitops/dev/storage"
  }
}
