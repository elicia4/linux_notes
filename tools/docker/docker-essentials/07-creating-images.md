# Creating Images

[***Table of Contents***](../README.md)

Start with a container that is a close to what you want to achieve as possible:

```bash
docker run -it ubuntu
apt update
apt dist-upgrade
apt install apache2
/etc/init.d/apache2 status
/etc/init.d/apache2 start
apt install vim
```

Disconnect from the container: `<CTRL+p+q>`

Check if its running with:

```bash
docker ps
```

How does one save a container?

```bash
docker ps # copy container ID
docker commit 32containerid lltv/apache-test:1.0
```

View docker images:

```bash
docker images
```

Stop running container:

```bash
docker stop 12containerid
```

Create container with the saved image:

```bash
docker run -d -it -p 8080:80 lltv/apache-test:1.0
```

Check server from browser:

```bash
localhost:8080
```

Apache isn't running? Why isn't it running? No entry point! What is an entry
point? It's essentially an instruction to docker about what command should be
run when a new container is created from an image. To create the needed entry
point type:

```bash
docker commit --change='ENTRYPOINT ["apachectl", "-DFOREGROUND"]' <ID> lltv/apache-test:1.1
```

Stop previous container:

```bash
docker stop <ID>
```

Launch the new one:

```bash
docker run -d -it -p 8080:80 lltv/apache-test:1.1
```

Check the website again, the web server should be working now :)

Let's automate all this!
Create a new folder, cd into it. Create a file named 'Dockerfile':

```bash
mkdir docker_files && cd docker_files && touch Dockerfile
```

Inside the file, type (comments aren't required):

```bash
###############################################
# Set the container image you want to start from
FROM ubuntu
# Set the maintainer variable
MAINTAINER John <john@someplace.com>
# Update packages
# RUN keyword runs the following command inside the container
RUN apt update; apt dist-upgrade -y
# Install packages
RUN apt install -y apache2 vim
# Set entrypoint
ENTRYPOINT apache2ctl -D FOREGROUND
###############################################
```

THIS CAN FAIL because of prompts, you should make the process non-interactive.
Add the following after "MAINTAINER" line:

```bash
ARG DEBIAN_FRONTEND=noninteractive
```

The file should be working now (`cd` into the `Dockerfile` directory first):

```bash
docker build --tag 'image_name' .
```

Run `docker ps`. 

Want to get rid of an image? Use:

```bash
docker rmi <IMAGE-ID>
```

And... It didn't work. The error is right. Run `docker ps -a`, you can probably
find the container.

Delete all the containers that use the image:

```bash
docker rm <CONTAINER-ID>
```

**BE CAREFUL WITH THIS**. If you want remove all *exited* and *created*
containers:

```bash
docker container prune
```

After you delete all of them, you will be able to delete the image:

```bash
docker rmi <IMAGE-ID>
```
