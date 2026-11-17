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
