# Nginx Dockerized Web Server

This project sets up a highly configurable Nginx web server using Docker, designed to handle both static websites and reverse proxy functionality for your Node.js applications running outside the container.

## Author / Developer

- **Anvesh** - [GitHub Profile](https://github.com/Anveshpoda)


## Features

* **Static Website Hosting:** Easily serve multiple static websites from a directory on your host machine.
* **Reverse Proxy:** Seamlessly proxy requests to your Node.js applications running on different ports on the host.
* **Dynamic Configuration:**  Automatically includes all configuration files from the `sites-available` directory.
* **Scalability:** Designed for potential scaling with load balancers and caching strategies.
* **Health Checks:** Includes the capability to add health checks for your proxied applications.

## Project Structure

```md
my-nginx-project/
├── Dockerfile             # Defines the Docker image
├── nginx.conf             # Main Nginx configuration
├── sites-available/       # Individual site configurations
│   ├── static-site1.conf
│   └── static-site2.conf
└── conf.d/                # Reverse proxy configuration(s)
    └── server.conf
```

## Prerequisites

* **Docker:** Make sure you have Docker installed and running on your system.
* **Node.js Applications:** Your Node.js applications should be running on the host machine on their respective ports.
* **Static Websites:** Ensure your static website files are located in the `/home/ubuntu/sites` directory (or adjust the path in the Dockerfile).

## How to Use

1. **Build the Docker Image:**
```bash
docker build -t myNginx . 
```

### To run this docker

Just run the following command to run the Docker

```bash
docker-compose up
```
run this to scale your Nginx service, it will run three instances of the Nginx container.

```bash
docker-compose up --scale nginx=3
```

To run this docker directly

```bash
docker run -d -p 80:80 \
           --add-host=host.docker.internal:host-gateway \
           -v /home/ubuntu/sites:/home/ubuntu/sites \
           --name NginxContainer myNginx
```

## Rewrite and Redirection

### CONFIG
keep the static sites conf in sites-available

```nginx
server {
    listen 80;
    server_name anveshpoda.tech; 
    root /home/ubuntu/sites/anveshpoda.tech;
    index index.html;
}
```
keep the sites running with ports conf in conf.d

```nginx
server {
    listen 80;
     server_name anveshpoda.tech; 
     root /home/ubuntu/sites/anveshpoda.tech;
     index index.html;
}
```

## Links
Some other awesome resources for configuring Nginx:

- [Nginx Official Guide](http://nginx.com/resources/admin-guide/)
- [HTML 5 Boilerplate's Sample Nginx Configuration](https://github.com/h5bp/server-configs-nginx)
- [Nginx Pitfalls](http://wiki.nginx.org/Pitfalls)
