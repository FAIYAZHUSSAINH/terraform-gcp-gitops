project_id  = "terraform-gcs-gitops"
region      = "asia-south1"
bucket_name = "terraform-gcs-gitops-lab-storage"

additional_buckets = {
  "fh-gitops-logs-1683-20261120" = {
    location = "asia-south1"
  }

  "fh-gitops-backups-1683-20261120" = {
    location = "us-central1"
  }
}
