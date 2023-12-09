# Installing Docker

[***Table of Contents***](../README.md)

1. Update your system:

   ```
   sudo apt update && sudo apt dist-upgrade # debian
   pacman -Syyu # arch
   ```

2. Install docker:

   ```
   sudo apt install docker.io
   pacman -S docker
   ```

3. Check if it's installed:

   ```
   systemctl status docker
   ```

   Enable and start it at the same time:

   ```
   systemctl enable --now docker
   ```

4. Test docker!

   ```
   sudo docker run hello-world
   ```

5. Add current user to the docker group:

   ```
   sudo usermod -aG docker $(whoami)
   ## whoami will output currently logged in user
   ```

6. Log out and in / Restart your pc
7. Try running the testing command without `sudo`, it should work:

   ```
   docker run hello-world
   ```

[***next note***](04-running-containers.md)
