variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "asia-south1"
}

variable "bucket_name" {
  description = "Existing data bucket for IAM grants"
  type        = string
}

variable "deployer_project_roles" {
  description = "Project-level roles for Terraform deployment"
  type        = map(string)
}

variable "terraform_state_bucket" {
  description = "GCS bucket containing Terraform state"
  type        = string
}
