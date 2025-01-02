# Base image
FROM ubuntu:20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Update and install required packages
RUN apt-get update && apt-get install -y \
    squid \
    apache2-utils \
    curl \
    ufw \
    && rm -rf /var/lib/apt/lists/*

# Copy Squid configuration
RUN touch /etc/squid/squid.conf \
    && curl -o /etc/squid/squid.conf https://raw.githubusercontent.com/Bhavya031/proxy/refs/heads/main/squid.conf

# Expose Squid default port
EXPOSE 3128

# Allow Squid to start correctly
RUN squid -k parse

# Add a health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s \
  CMD squid -k check || exit 1

# Start Squid service
CMD ["squid", "-N"]
