#!/usr/bin/env bash
set -euo pipefail

NAMESPACE="supabase"
HELM_RELEASE="supabase"

echo "🚨 WARNING: This will delete all Supabase-related resources in namespace: $NAMESPACE"
read -p "Proceed? (y/N): " confirm
[[ "$confirm" != "y" ]] && exit 1

echo "👉 Uninstalling Helm release: $HELM_RELEASE"
helm uninstall $HELM_RELEASE -n $NAMESPACE || true

echo "👉 Deleting namespace: $NAMESPACE"
kubectl delete namespace $NAMESPACE --ignore-not-found=true

echo "👉 Deleting dangling PVCs"
kubectl get pvc -A | grep supabase | awk '{print $2, $1}' | \
  while read pvc ns; do
    kubectl delete pvc "$pvc" -n "$ns" --ignore-not-found=true
  done

echo "👉 Deleting dangling PVs"
kubectl get pv | grep supabase | awk '{print $1}' | \
  xargs -r kubectl delete pv

echo "👉 Deleting ExternalSecrets + CRDs"
kubectl get externalsecret -A --no-headers | awk '{print $1, $2}' | \
  while read ns name; do
    kubectl delete externalsecret "$name" -n "$ns" --ignore-not-found=true
  done

# Optional: nuke CRDs (be careful if other clusters use external-secrets too!)
echo "👉 Deleting external-secrets CRDs (optional full cleanup)"
kubectl get crds | grep external-secrets.io | awk '{print $1}' | \
  xargs -r kubectl delete crd

echo "✅ Cleanup complete. You can now redeploy Supabase cleanly."
