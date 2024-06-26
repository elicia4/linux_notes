# Running Containers

[***Table of Contents***](../README.md)

Show docker images that have been downloaded and are locally available:

```bash
docker images
```

Look for a docker image, for example the Ubuntu image:

```bash
docker search ubuntu
```

Download the docker image:

```bash
docker pull ubuntu
```

Run a container created from that image:

```bash
docker run ubuntu
```

So... you are back to the prompt. Containers automatically exit if they have
nothing to do. Some containers start running some job whenever they start, but
it's not the case with Ubuntu. Try running:

```bash
docker run nginx
```

If a docker image doesn't exist locally but is available, it will be downloaded
automatically and launched if you run the `docker run image-name` command.

List containters that are running on your system:

```bash
docker ps
```

List all containers:

```bash
docker ps -a
```

Run `bash` inside Ubuntu container:

```bash
docker run -it ubuntu /bin/bash
```

You are now "inside" the container! Do whatever you want! Containers don't
save changes by default. Update the system:

```bash
apt update
```

Install `vim`:

```bash
apt install vim
```

You can install anything you want!  

You can even install a GUI app from containers.  

You should practice settings up containers :)  

For instance, you could practice using various package managers on popular
distributions.

[***next note***](05-making-containers-persist.md)
