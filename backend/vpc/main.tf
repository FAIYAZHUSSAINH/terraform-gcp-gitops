
module "vpc" {
  source = "git::https://github.com/FAIYAZHUSSAINH/terraform-gcp-modules.git//vpc?ref=v1.0.0"

  vpc_name    = var.vpc_name
  subnet_name = var.subnet_name
  subnet_cidr = var.subnet_cidr
  region      = var.region
}
