variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "additional_buckets" {
  description = "Additional GCS buckets with individual locations"

  type = map(object({
    location = string
  }))

  default = {}
}
