project_id = "terraform-gcs-gitops"
region     = "asia-south1"
zone       = "asia-south1-a"

vm_name      = "gitops-dev-vm"
machine_type = "e2-medium"

additional_vms = {
  "gitops-dev-vm-2" = {
    machine_type          = "e2-small"
    zone                  = "asia-south1-a"
    service_account_email = "internship-app-sa@terraform-gcs-gitops.iam.gserviceaccount.com"
  }

  "gitops-dev-vm-3" = {
    machine_type          = "e2-small"
    zone                  = "asia-south1-a"
    service_account_email = "internship-app-sa@terraform-gcs-gitops.iam.gserviceaccount.com"
  }
}
