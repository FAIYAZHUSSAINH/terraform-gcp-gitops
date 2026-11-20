project_id  = "terraform-gcs-gitops"
bucket_name = "terraform-gcs-gitops-lab-storage"

deployer_project_roles = {
  compute = "roles/compute.instanceAdmin.v1"
  network = "roles/compute.networkAdmin"
  storage = "roles/storage.admin"
}

terraform_state_bucket = "terraform-bucket-is-mine"
