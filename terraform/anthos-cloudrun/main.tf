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

data "google_iam_policy" "cloudrun_gsa_policy" {
  binding {
    role = "roles/iam.workloadIdentityUser"
    members = [
      "serviceAccount:${var.project_id}.svc.id.goog[knative-serving/controller]",
    ]
  }
}

resource "google_service_account_iam_policy" "cloudrun_gsa" {
  service_account_id = module.cloudrun_gsa.service_account.name
  policy_data        = data.google_iam_policy.cloudrun_gsa_policy.policy_data
}

module "gcloud" {
  source  = "terraform-google-modules/gcloud/google"
  version = "3.1.0"

  create_cmd_entrypoint  = "gcloud"
  create_cmd_body        = "container hub cloudrun enable --project=${var.project_id}"
}
