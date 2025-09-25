#!/usr/bin/env bash
set -euo pipefail

# ----------------------------------------------------------------------
# Step 1: Namespace + ServiceAccount
# ----------------------------------------------------------------------
echo "🔹 Creating supabase namespace..."
kubectl apply -f k8s/namespace.yaml

echo "🔹 Creating ServiceAccount with IRSA ARN..."
IRSA_ARN="$(terraform -chdir=infra output -raw supabase_secrets_irsa_role_arn)"
sed "s|REPLACE_ME_IRSA_ARN|$IRSA_ARN|g" k8s/serviceaccount-supabase.yaml | kubectl apply -f -

# ----------------------------------------------------------------------
# Step 2: Install ESO CRDs + Controller (pinned v0.14.3)
# ----------------------------------------------------------------------
echo "🔹 Installing External Secrets Operator CRDs..."
kubectl apply -f https://raw.githubusercontent.com/external-secrets/external-secrets/v0.14.3/deploy/crds/bundle.yaml

echo "🔹 Installing External Secrets Operator via Helm..."
helm repo add external-secrets https://charts.external-secrets.io || true
helm repo update
kubectl create namespace external-secrets --dry-run=client -o yaml | kubectl apply -f -
helm upgrade --install external-secrets external-secrets/external-secrets \
  -n external-secrets --version 0.14.3

echo "🔹 Waiting for ESO controller and webhook to be ready..."
kubectl rollout status deployment/external-secrets -n external-secrets --timeout=180s

# ----------------------------------------------------------------------
# Step 3: Apply ClusterSecretStore + ExternalSecret
# ----------------------------------------------------------------------
echo "🔹 Applying ClusterSecretStore (AWS Secrets Manager backend)..."
kubectl apply -f k8s/external-secrets/cluster-secret-store.yaml

echo "🔹 Applying ExternalSecret for supabase..."
kubectl apply -f k8s/external-secrets/externalsecret-supabase.yaml

# ----------------------------------------------------------------------
# Step 4: Wait for secrets
# ----------------------------------------------------------------------
echo "🔹 Waiting for supabase-secrets Secret to appear..."
for i in {1..30}; do
  if kubectl -n supabase get secret supabase-secrets >/dev/null 2>&1; then
    echo "✅ supabase-secrets is ready!"
    kubectl -n supabase get secret supabase-secrets -o yaml
    break
  fi
  echo "⏳ still waiting..."
  sleep 5
done

# ----------------------------------------------------------------------
# Step 5: Generate values file with pinned image tags
# ----------------------------------------------------------------------
echo "🔹 Generating k8s/values-supabase.yaml with pinned images..."
mkdir -p k8s
cat > k8s/values-supabase.yaml <<'EOF'
edge-runtime:
  image:
    repository: supabase/edge-runtime
    tag: v1.47.1

gotrue:
  image:
    repository: supabase/gotrue
    tag: v2.130.3

postgrest:
  image:
    repository: postgrest/postgrest
    tag: v12.2.3

realtime:
  image:
    repository: supabase/realtime
    tag: v2.25.48

storage:
  image:
    repository: supabase/storage-api
    tag: v0.49.4

imgproxy:
  image:
    repository: darthsim/imgproxy
    tag: v3.16.0

# PVC + autoscaling defaults
postgrest:
  resources:
    requests:
      cpu: "100m"
      memory: "128Mi"
    limits:
      cpu: "500m"
      memory: "512Mi"
  autoscaling:
    enabled: true
    minReplicas: 1
    maxReplicas: 3
    targetCPUUtilizationPercentage: 80
EOF

# ----------------------------------------------------------------------
# Step 6: Deploy Supabase via Helm (local chart)
# ----------------------------------------------------------------------
echo "🔹 Cloning supabase-kubernetes chart..."
rm -rf supabase-kubernetes || true
git clone https://github.com/supabase-community/supabase-kubernetes.git

echo "🔹 Installing Supabase via Helm (local chart with pinned images)..."
helm upgrade --install supabase ./supabase-kubernetes/charts/supabase \
  -n supabase \
  -f k8s/values-supabase.yaml

echo "✅ Supabase deployed successfully!"
