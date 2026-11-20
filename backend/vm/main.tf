
data "terraform_remote_state" "vpc" {
  backend = "gcs"

  config = {
    bucket = "terraform-bucket-is-mine"
    prefix = "gitops/dev/vpc"
  }
}

module "vm" {

  source       = "git::https://github.com/FAIYAZHUSSAINH/terraform-gcp-modules.git//vm?ref=v1.0.0"
  vm_name      = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone

  subnet_id = data.terraform_remote_state.vpc.outputs.subnet_id
}

module "additional_vms" {
  for_each = var.additional_vms

  source = "git::https://github.com/FAIYAZHUSSAINH/terraform-gcp-modules.git//vm?ref=dedaaea1d38a02aba22c43b886a2e95d9ed107a9"

  vm_name               = each.key
  machine_type          = each.value.machine_type
  zone                  = each.value.zone
  service_account_email = each.value.service_account_email

  subnet_id = data.terraform_remote_state.vpc.outputs.subnet_id
}
