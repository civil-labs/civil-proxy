#!/bin/bash
set -e

# 1. Fail fast if any required variables are missing from the Fargate task
if [ -z "$SERVICE_NAME" ] || [ -z "$EGRESS_PORT" ] || [ -z "$LOCAL_APP_PORT" ]; then
    echo "FATAL: Missing required routing environment variables."
    echo "Check that SERVICE_NAME, INGRESS_PORT, EGRESS_PORT, and LOCAL_APP_PORT are injected via OpenTofu."
    exit 1
fi

echo "Bootstrapping Envoy sidecar for service: ${SERVICE_NAME}"

# 2. Inject the variables into the template
# We write the final config to /tmp/envoy.yaml because /tmp is always writable, 
# preventing permission errors when running as the custom ENVOY_UID 1337.
envsubst < /tmpl/envoy.template.yaml > /tmp/envoy.yaml

echo "Configuration generated successfully. Handing over to Envoy..."

# 3. The PID 1 Handoff
# Using 'exec' is mandatory. It replaces this bash script with the Envoy binary 
# as Process ID 1. If you omit 'exec', Envoy runs as a subprocess, it won't 
# receive the SIGTERM from AWS when scaling down, and your deployments will hang.
exec envoy -c /tmp/envoy.yaml