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
nginx-project/
├── Dockerfile             # Defines the Docker image
├── nginx.conf             # Main Nginx configuration
└── .env                   # Define root dir which contains the configuration and sites

```
**Create Root dir for static sites and Create a sub folder named *config* in it then define it in .env**

```md

  www/
    ├── config/
    │   ├── sites-available/         # Individual site configurations
    │   │   ├── static-site1.conf
    │   │   └── static-site2.conf
    │   └── conf.d/                  # Reverse proxy configuration(s)
    │       └── server.conf
    ├── site1/
    │   └── ... (site 1 files)
    ├── site2/
    │   └── ... (site 2 files)
    └── ... (other site directories)

```

## Prerequisites

* **Docker:** Make sure you have Docker installed and running on your system.
* **Environment File**
    This file contains the `VOLUME_PATH` variable, which needs to be set differently depending on the operating system:
    * **Windows:** VOLUME_PATH=D:/www
    * **Linux:** VOLUME_PATH=/home/ubuntu/www
    * **macOS:** VOLUME_PATH=/Users/yourusername/www
    **Note:** *It is Mandatory to specify the `VOLUME_PATH` based on the operating system in .env or docker-compose.yml file*
        
* **Node.js Applications:** Your Node.js applications should be running on the host machine on their respective ports.
* **Static Websites:** Ensure your static website files are located in the `VOLUME_PATH` directory.

## How to Use

1. **Build the Docker Image:**
```bash
docker build -t my-nginx . 
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
           -v /home/ubuntu/www:/www \
           --name NginxContainer my-nginx
```

## Rewrite and Redirection

### CONFIG
keep the static sites conf in sites-available

```nginx
    server {
        listen 80;
        server_name anveshpoda.tech; 
        root /www/anveshpoda.tech;
        index index.html;
    }
```
keep the sites running with ports conf in conf.d

```nginx
    server {
        listen 80;
        server_name react.anveshpoda.tech;

        location / {
            proxy_pass http://host.docker.internal:3000; 
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
        }
    }
```

## Links
Some other awesome resources for configuring Nginx:

- [Nginx Official Guide](http://nginx.com/resources/admin-guide/)
- [HTML 5 Boilerplate's Sample Nginx Configuration](https://github.com/h5bp/server-configs-nginx)
- [Nginx Pitfalls](http://wiki.nginx.org/Pitfalls)
