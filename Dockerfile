# Use the official Envoy proxy image (v1.30 is a recent, stable release)
FROM envoyproxy/envoy:v1.30-latest

# Copy your configuration file into the container
COPY envoy.yaml /etc/envoy/envoy.yaml

# gateway Ingress
EXPOSE 8081
# gateway Egress
EXPOSE 8082
# tile-server Ingress
EXPOSE 8083
# idp Ingress
EXPOSE 8084
# idp egress
EXPOSE 8085
# ldap-server TCP Ingress
EXPOSE 8086
# ldap-server HTTP Ingress
EXPOSE 8087
# database-reader Ingress
EXPOSE 8088
# database-writer Ingress
EXPOSE 8089
# Admin Interface
EXPOSE 9901

# The base image already has the ENTRYPOINT configured to start Envoy,
# so no CMD or ENTRYPOINT override is necessary unless you need to pass specific flags.