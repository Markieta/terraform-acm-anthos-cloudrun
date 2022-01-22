module "cloudrun_gsa" {
  source  = "terraform-google-modules/service-accounts/google"
  version = "4.1.0"
  project_id    = var.project_id
  generate_keys = true
  names         = ["${var.cloudrun_gsa}"]
  display_name  = "Cloud Run for Anthos Metrics Writer"
  project_roles = [
    "${var.project_id}=>roles/monitoring.metricWriter",
  ]
}

resource "null_resource" "enable_cloudrun" {
  provisioner "local-exec" {
    command = "gcloud container hub cloudrun enable --project=${var.project_id}"
  }
}
