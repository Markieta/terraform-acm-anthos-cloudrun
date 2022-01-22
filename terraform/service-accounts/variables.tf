variable "project_id" {
    description = "GCP Project ID."
    type = string
}

variable "cloudrun_gsa" {
    default = "cloudrun-metrics"
    description = "Google Service Account assigned Metric Writer role for Cloud Run for Anthos."
}
