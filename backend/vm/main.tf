
data "terraform_remote_state" "vpc" {
  backend = "gcs"

  config = {
    bucket = "terraform-bucket-is-mine"
    prefix = "gitops/dev/vpc"
  }
}

module "vm" {

  source = "git::https://github.com/FAIYAZHUSSAINH/terraform-gcp-modules.git//vm?ref=v1.0.0"
  vm_name      = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone

  subnet_id = data.terraform_remote_state.vpc.outputs.subnet_id
}
