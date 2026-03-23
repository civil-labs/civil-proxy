# Use the official Envoy proxy image (v1.30 is a recent, stable release)
FROM envoyproxy/envoy:v1.30-latest

# Copy your configuration file into the container
COPY envoy.yaml /etc/envoy/envoy.yaml

# Remote Ingress
EXPOSE 8080
# Local Ingress
EXPOSE 8081
# Admin Interface
EXPOSE 9901

# The base image already has the ENTRYPOINT configured to start Envoy,
# so no CMD or ENTRYPOINT override is necessary unless you need to pass specific flags.