FROM nginx:latest

# Install curl and inotify-tools
RUN apt-get update && apt-get install -y curl inotify-tools

# Copy your main Nginx configuration file
COPY nginx.conf /etc/nginx/nginx.conf

# Expose the port Nginx will listen on (80 by default)
EXPOSE 80

# Mount static sites and configuration directories from the host machine
# Define default volume path as an environment variable (this will be overridden at runtime)
ENV VOLUME_PATH=/home/ubuntu/sites

# Start Nginx and the configuration watcher script
CMD ["/bin/bash", "-c", "nginx -g 'daemon off;' & \
    while inotifywait -r -e create,delete,modify,move $VOLUME_PATH/config; do \
        find $VOLUME_PATH/config/sites-available -name '*.conf' -exec ln -s {} /etc/nginx/sites-enabled/ \; \
        if ! cp -r $VOLUME_PATH/config/conf.d/* /etc/nginx/conf.d/; then \
            echo \"Error copying conf.d files\" >&2; \
        fi \
        if ! nginx -s reload; then \
            echo \"Error reloading Nginx\" >&2; \
        fi \
    done"]