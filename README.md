# docker-zero-downtime-deployment

## Use Case

This repository is useful if you

- Use docker compose to host docker containers in a Virtual Machine
- Use Nginx to route requests to different containers
- Want to achieve zero-downtime deployment in a simplest way

## Why?

There are many solutions available for achieving zero-downtime deployment, but sometimes we just want a simple solution tailored to our specific use case.

While researching solutions for my use case, I came across [this article](https://www.tines.com/blog/simple-zero-downtime-deploys-with-nginx-and-docker-compose/) to achieve it using only bash script, but it lacked a complete code example for implementation.

This repository aims to provide a comprehensive code example and guide on how to achieve zero-downtime deployment for a Docker Compose and Nginx project.

Check out [my article](https://medium.com/@hohin523/the-easiest-way-to-achieve-zero-downtime-deployment-using-docker-compose-and-nginx-9ba8fc733948) for more details.

## How?

1. Configure `docker-compose.yml` according to your need
2. In `upload_new_image.sh`, update the container name to your target container name. You can tailor the script any way you want, since the ultimate goal for this file is to prepare a docker image in the VM
3. In `deploy.sh`, update `service_name` to your target container name
4. Upload `deploy.sh`, `docker-compose.yml` and `nginx.conf` to your VM
5. Run `chmod +x ./deploy.sh` to make it executable
6. Run `./deploy.sh` to start the deployment
