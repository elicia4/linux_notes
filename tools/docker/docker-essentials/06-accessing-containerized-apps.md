# Accessing Containerized Applications

[***Table of Contents***](../README.md)

Let's try running a different container:

```bash
docker run nginx
```

It's trying to run an entry point command. It's a command in the container that
is executed automatically. The container ends up being completely useless.
Let's create an nginx container with the following command instead:

```bash
docker run -it -d -p 8080:80 nginx
```

`-p` stands for port, `8080` is opened locally, mapped as `80` to container.

Then:

```bash
ip -a
```

Copy the IP address of the local system.
Type it into your web browser with `:8080` at the end:

```bash
120.120.120.120:8080
```

OR just use `localhost`:

```bash
localhost:8080
```

To stop a container, you can:

```bash
docker stop <id>
```

Add `--restart unless-stopped` arguments to the command:

```bash
docker run -it -d --restart unless-stopped -p 8080:80 nginx
```

Those arguments are useful for web-servers.

### Restart in Case of Failure

Docker provides a restart policy option to let your containers restart
automatically in case of certain events or failures.

This is extremely helpful in scenarios where you have to restart the Docker
host or if the service running in the container fails.

`unless-stopped`: Restart the container unless the container was in stopped
state before the Docker daemon was stopped. If you stop the containers with
the `docker stop` command and then restart the docker daemon, the container
with `unless-stopped` policy won't be restarted.

[***next note***](07-creating-images.md)
