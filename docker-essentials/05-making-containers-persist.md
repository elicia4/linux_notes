# Making Containers Persist

[***go back to contents***](01-contents.md)

If a container has nothing to do, it deletes itself.

Let's explore how to keep the container running in the background:

	docker run -it ubuntu

Means the same thing as:

	docker run -it ubuntu /bin/bash

To run a container in the background:

	docker run -it -d ubuntu

`-it` creates an interactive shell inside the container, => creates an
interactive container

`-d` activates daemon mode (daemon is another word for service).

To connect to a container running in the background:

	docker attach <container-id>
    # (to get container id: docker ps -> copy container id)

You can shorten the id to the combination of unique characters, imagine you
have the following `ID's`:

	06asdfasdf, 0701230912dj

If you run `docker attach 06` it will launch the container starting with `06`.

To send the container back to the background, `<CTRL+P+Q>`.

[go to next note](06-accessing-containerized-apps.md)
