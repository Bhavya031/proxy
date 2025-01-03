# Use Ubuntu 20.04 as the base image
FROM ubuntu:24.04.1

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Update and install required packages
RUN apt-get update && apt-get install -y \
    squid \
    apache2-utils \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy Squid configuration
RUN curl -o /etc/squid/squid.conf https://raw.githubusercontent.com/Bhavya031/proxy/refs/heads/main/squid.conf

# Expose Squid's default port
EXPOSE 3128

# Verify Squid configuration
RUN squid -k parse

# Start Squid service
CMD ["squid", "-N"]

