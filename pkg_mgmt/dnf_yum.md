# `dnf` and `yum`

Notes taken on the [Linux Crash Course - The dnf
Command](https://youtu.be/oPEnvuj9QrI) video by LearnLinuxTV and other
resources.

[***Table of Contents***](/README.md)  

`dnf` is a package manager, it can be found in Fedora, CentOS, RedHat, Rocky
and so on. `dnf` (Dandified YUM) is the modern version of `yum` (Yellowdog
Updater Modifier), its predecessor. 

A package manager is a command line utility that fetches software from a remote
repository. 

Let's install `htop`:

```bash
sudo dnf install htop
sudo yum install htop
```

Press `y`, you can just skip through here like in other package managers
because the default option here is `N`(no). After it completes, test `htop`:

```bash
htop
```

To search for a package:

```bash
dnf search apache
yum search keyword 	
```

You get lots of results, the name is in front of the name of the architecture
of the package(`.x86_64`), you can install Apache now:

```bash
sudo dnf install httpd
sudo yum install httpd
```

To list installed packages:

```bash
dnf list installed
yum list installed
```

It will list both automatically and manually installed packages. 

To list packages that have been recently updated in the repositories:

```bash
dnf list recent
yum list recent
```

A repository is the server where the the software comes from.

You can install more than one package at a time:

```bash
sudo dnf install alacritty ulauncher
sudo yum install alacritty ulauncher
```

To remove a package:

```bash
sudo dnf remove htop
sudo yum remove htop
```

You can install more than one package at a time:

```bash
sudo dnf remove alacritty ulauncher
sudo yum remove alacritty ulauncher
```

To upgrade a package to the latest version, note that the dependancies are
upgraded as well:

```bash
sudo dnf upgrade firefox
sudo yum upgrade firefox
```

To update EVERYTHING:

```bash
sudo dnf upgrade
sudo yum upgrade
```

Do it all the time, it improves security. You can set up automatic updates with
`dnf-automatic`:

```bash
sudo dnf install dnf-automatic
```

Then make changes to the configuration:

```bash
sudo vim /etc/dnf/automatic.conf
```

If you only want to do the security upgrades, change the `upgrade_type`
parameter to `security`. This is particularily good for servers. 

Let's say one of your packages is acting weird, you get errors all the time and
so on. Reinstalling a package might fix your problems:

```bash
sudo dnf reinstall htop
sudo yum reinstall htop
```

To remove unused packages:

```bash
sudo dnf autoremove
sudo yum autoremove
```

### List of Commands

1. Install a package:

   ```bash
   sudo yum install package_name 	
   sudo dnf install package_name
   ```

1. Update a package:

   ```bash
   sudo yum update package_name 	
   sudo dnf update package_name
   ```

1. Remove a package:

   ```bash
   sudo yum remove package_name 	
   sudo dnf remove package_name
   ```

1. Search for a package:

   ```bash
   yum search keyword 	
   dnf search keyword
   ```

1. List all installed packages:

   ```bash
   yum list installed 	
   dnf list installed
   ```

1. Check for available updates:

   ```bash
   yum check-update 	
   dnf check-update
   ```

1. Clean cached data:

   ```bash
   sudo yum clean all 	
   sudo dnf clean all
   ```

1. List enabled repositories: 	

   ```bash
   yum repolist
   dnf repolist
   ```

1. Enable a repository:

   ```bash
   sudo yum-config-manager --enable repo_name 	
   sudo dnf config-manager --set-enabled repo_name
   ```

1. Disable a repository:

   ```bash
   sudo yum-config-manager --di
   sable repo_name 	sudo dnf config-manager --set-disabled repo_name
   ```

1. Upgrade all packages:

   ```bash
   sudo yum upgrade 	
   sudo dnf upgrade
   ```

1. Show package information:

   ```bash
   yum info package_name 	
   dnf info package_name
   ```

1. Find which package provides a file:

   ```bash
   yum provides file_name 	
   dnf provides file_name
   ```

1. Check package dependencies:

   ```bash
   yum deplist package_name 	
   dnf repoquery --requires --resolve package_name
   ```

1. Download a package without installing:

   ```bash
   yum download package_name 	
   dnf download package_name
   ```

1. Install a local RPM package:

   ```bash
   sudo yum local install /full/path/to/package_name.rpm 	
   sudo dnf install /full/path/to/package_name.rpm
   ```

1. Lock a package version:

   ```bash
   sudo yum versionlock package_name 	
   sudo dnf versionlock add package_name
   ```

1. Unlock a package version:

   ```bash
   sudo yum versionlock delete package_name 	
   sudo dnf versionlock delete package_name
   ```

1. Reinstall a package:

   ```bash
   sudo yum reinstall package_name 	
   sudo dnf reinstall package_name
   ```

1. List all available packages:

   ```bash
   yum list all 	
   dnf list all
   ```

1. Remove unused packages:

   ```bash
   sudo dnf autoremove
   sudo yum autoremove
   ```
