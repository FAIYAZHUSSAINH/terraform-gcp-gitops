variable "project_id" { type = string }
variable "region" { type = string }
variable "zone" { type = string }
variable "vm_name" { type = string }
variable "machine_type" { type = string }

variable "additional_vms" {
  description = "Additional VMs with individual configurations"

  type = map(object({
    machine_type          = string
    zone                  = string
    service_account_email = string
  }))

  default = {}
}
