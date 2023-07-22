# Running Containers

Show docker images that have been downloaded and are locally available:

	docker images

Look for a docker image, for example the ubuntu image:

	docker search ubuntu

Download docker image:

	docker pull ubuntu

Run a container created from that image:

	docker run ubuntu

So... you are back to the prompt. Containers automatically exit if they have
nothing to do. Some containers start running some job whenever they start, but
it's not the case with ubuntu. Try running:

	docker run nginx

If a docker image doesn't exist locally but is available, it will be downloaded
automatically and launched if you run the `docker run image-name` command.

List containters that are running on your system:

	docker ps

List all containers:

	docker ps -a

Run bash inside ubuntu container:

	docker run -it ubuntu /bin/bash

You are now "inside" the container! Do whatever you want!  Containers don't
save changes by default. Update the system:

	apt update

Install `vim`:

	apt install vim

You can install anything you want!
You can even install a GUI app from containers.
You should practice settings up containers :)
For instance, you could practice using various package managers on popular
distributions.
