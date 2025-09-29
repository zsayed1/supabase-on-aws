#!/usr/bin/env bash
set -euo pipefail

echo "🔹 Creating supabase namespace..."
kubectl apply -f k8s/namespace.yaml

echo "🔹 Creating ServiceAccount with IRSA ARN..."
IRSA_ARN="$(terraform -chdir=infra output -raw supabase_secrets_irsa_role_arn)"
sed "s|REPLACE_ME_IRSA_ARN|$IRSA_ARN|g" k8s/serviceaccount-supabase.yaml | kubectl apply -f -

echo "🔹 Installing External Secrets Operator via Helm..."
helm repo add external-secrets https://charts.external-secrets.io
helm repo update
kubectl create namespace external-secrets --dry-run=client -o yaml | kubectl apply -f -
helm upgrade --install external-secrets external-secrets/external-secrets -n external-secrets

echo "🔹 Waiting for ESO pods to be ready..."
kubectl rollout status deployment/external-secrets -n external-secrets --timeout=180s || {
  echo "❌ ESO pods not ready in time"
  exit 1
}

echo "🔹 Waiting for External Secrets CRDs to be established..."
CRDS=(
  "clustersecretstores.externalsecrets.io"
  "secretstores.externalsecrets.io"
  "externalsecrets.externalsecrets.io"
)

for crd in "${CRDS[@]}"; do
  for i in {1..60}; do
    if kubectl get crd "$crd" >/dev/null 2>&1; then
      echo "✅ CRD $crd is ready"
      break
    fi
    echo "⏳ waiting for CRD $crd..."
    sleep 5
  done
done

echo "🔹 Applying ClusterSecretStore (AWS Secrets Manager backend)..."
kubectl apply -f k8s/external-secrets/cluster-secret-store.yaml

echo "🔹 Applying ExternalSecret for supabase..."
kubectl apply -f k8s/external-secrets/externalsecret-supabase.yaml

echo "🔹 Waiting for supabase-secrets Secret to appear..."
for i in {1..60}; do
  if kubectl -n supabase get secret supabase-secrets >/dev/null 2>&1; then
    echo "✅ supabase-secrets is ready!"
    kubectl -n supabase get secret supabase-secrets -o yaml
    exit 0
  fi
  echo "⏳ still waiting..."
  sleep 5
done

echo "❌ Timeout waiting for supabase-secrets"
exit 1
