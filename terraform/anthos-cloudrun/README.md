# Notes

## Post-Terraform

Create a secret in the `knative-serving` namespace using the Cloud Run for Anthos Metrics Writer GSA:

```bash
GSA_KEY_PATH='/tmp/key.json'

terraform output -raw cloudrun_gsa_key > $GSA_KEY_PATH
kubectl create secret -n knative-serving generic cloudrun-metrics-gsa --from-file=$GSA_KEY_PATH
rm $GSA_KEY_PATH
```
