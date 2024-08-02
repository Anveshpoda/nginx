FROM nginx:latest

# Install curl to allow health checks on proxied services
RUN apt-get update && apt-get install -y curl

# Copy your Nginx configuration files
COPY nginx.conf /etc/nginx/nginx.conf
COPY sites-available/ /etc/nginx/sites-available/
COPY conf.d/ /etc/nginx/conf.d/

# Create symbolic links for all static site configurations in sites-enabled
RUN find /etc/nginx/sites-available -name "*.conf" -exec ln -s {} /etc/nginx/sites-enabled/ \;

# Mount static sites from the host machine
VOLUME /home/ubuntu/sites

# Expose the port Nginx will listen on (80 by default)
EXPOSE 80
