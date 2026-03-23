# Use the official Envoy proxy image (v1.30 is a recent, stable release)
FROM envoyproxy/envoy:v1.30-latest

# Copy your configuration file into the container
COPY envoy.yaml /etc/envoy/envoy.yaml

# gateway Ingress
EXPOSE 8080
# gateway Egress
EXPOSE 8081
# tile-server Ingress
EXPOSE 8082
# idp Ingress
EXPOSE 8083
# idp egress
EXPOSE 8084 
# ldap-server TCP Ingress
EXPOSE 8085
# ldap-server HTTP Ingress
EXPOSE 8086
# database-reader Ingress
EXPOSE 8087
# database-writer Ingress
EXPOSE 8088
# Admin Interface
EXPOSE 9901

# The base image already has the ENTRYPOINT configured to start Envoy,
# so no CMD or ENTRYPOINT override is necessary unless you need to pass specific flags.