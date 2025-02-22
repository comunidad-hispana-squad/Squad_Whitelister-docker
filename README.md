# Squad_Whitelister Docker

This is a docker image for [Squad_Whitelister](https://github.com/fantinodavide/Squad_Whitelister).
Runs with pm2 to mantain the process uptime and uses the `-slim` image to reduce image size.

## Using the image

```yaml
services:
    whitelister:
        image: ghcr.io/comunidad-hispana-squad/squad_whitelister-docker:<version>
        volumes:
        - ./conf.js:/app/conf.js
    
    mongodb:
        ...
```


## Upgrading the image

Change the `ARG` as required. Increase the `version` label.
Create a new release.


## Working locally

```bash
docker build . -t whitelister-docker

docker run --rm -it localhost/whitelister-docker
```
