
data "terraform_remote_state" "vpc" {
  backend = "gcs"

  config = {
    bucket = "terraform-bucket-is-mine"
    prefix = "gitops/dev/vpc"
  }
}

module "vm" {
  source = "../../modules/vm"

  vm_name      = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone

  subnet_id = data.terraform_remote_state.vpc.outputs.subnet_id
}
