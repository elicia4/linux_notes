# The Apache Web Server

Notes taken on this video by LearnLinuxTV: https://youtu.be/1CDxpAzvLKY

[***go back to README***](README.md)  

## Basics of Apache

1. Connect to a remote server:

    ssh <user>@<remote>

2. Update your system to make sure everything is up-to-date:

    ```
    apt update
    apt dist-upgrade
    ```
3. Update the hostname to make it more descriptive:

    vim /etc/hostname

   You can set the domain name or a function of the server as the hostname. 

4. If this is the only thing you do, you will get an error after executing some
   commands:

    unable to resolve host new-hostname

   To fix the issue, you have to edit the `etc/hosts` file, add a line after
   the first one:

    vim /etc/hosts

   Make it look like so:

    ```
    127.0.0.1 localhost
    127.0.1.1 new-hostname # this is the line you have to add 
    ```

5. To check the uptime of the server:
    
    uptime 

6. Now install **Apache**:

    apt install apache2 apache2-doc apache2-utils

   Accept all the defaults.

7. Check the status of `apache2`:

    systemctl status apache2

   If you see that it's `active (running)`, you did everything right :)

1. In for some reason it's disabled, you should enable it:

    systemctl enable --now apache2

1. Let's get to configuring it now. There are modules that can be installed to 
   extend Apache's functionality. The modules themselves depend on what exactly
   you want to host with Apache. If you all you want to do is host a single
   static webpage, you don't need anything else, you already have everything
   you need. If you want to configure "NextCloud", "WordPress", and so on,
   refer to their documentation, you can find what modules you need there. To
   see the modules that are available:

    apt search libapache2-mod

   Some will pop up that are not related, but the ones that start with
   `libapache2-mod-` obviously are. If for instance you wanted to add `python`
   support:

    apt install libapache2-mod-python

   Another popular example is:

    apt install libapache2-mod-perl2

1. When it comes to Ubuntu, there's a very specific way you can disable or
   enable modules. Ubuntu tries to enable all modules by default, but in case
   you need to do it manually:

    a2enmod

   And then follow the instructions in the prompt:

    Your choices are: <all-modules>
    Which module(s) do you want to enable (wildcards ok)? 

1. To disable a module:
    
    a2dismod

   And then follow the instructions in the prompt:

    Your choices are: <enabled-modules>
    Which module(s) do you want to disable (wildcards ok)? 

   Note that after disabling, you need to restart `apache2`:

    systemctl restart apache2

   A `reload` won't do, it's a lot more graceful than `restart`.

1. Apache is able to host more than one website on the same server. In order to
   do that, there's a feature called "name-based virtual host". Ubuntu has two
   commands that allow us to do stuff:

    a2ensite
    a2dissite

   To see what sites you can enable or disable:

    ls /etc/apache2/sites-available/

   You can see all the config files that are available right there. Let's
   disable the default site:

    a2dissite 000-default

   Note that you have to `reload`:

    ```
    To activate the new configuration, you need to run:
      systemctl reload apache2
    ```

1. Let's create a custom site now :)

    vim /etc/apache2/sites-available/example.net.conf

   The example config is:

    ```
    # The virtual host is listening for connections on port 80, which is the default
    <VirtualHost *:80>
        # The individual that is responsible for the site
        ServerAdmin webmaster@example.net
        # The name of the server
        ServerName example.net
        # The same as the server but with "www"
        ServerAlias www.example.net
        # Self-explanatory
        DocumentRoot /srv/www/example.net/public_html/
        ErrorLog /srv/www/example.net/logs/error.log
        CustomLog /srv/www/example.net/logs/access.log combined
    </VirtualHost>
    ```

   To add scripting support for pearl, add the following lines:
    
    ```
    Options ExecGUI
    AddHandler cgi-script .pl
    ```

   Other scripting languages will require some different configurations, refer
   to documentation.

1. The directory that the `DocumentRoot` references doesn't exist for either of
   those virtuals hosts. We will need to create that:

    mkdir -p /srv/www/example.net/public_html
    mkdir -p /srv/www/example.org/public_html

   The `-p` option will create parent directories if they don't already exist.
   You also have to create the "log" files:

    mkdir -p /srv/www/example.net/public_html
    mkdir -p /srv/www/example.org/public_html

1. Now enable the websites:

    ```
    a2ensite example.net
    a2ensite example.org
    ```
   Now we have 2 websites that are being hosted on this server. If you want to 
   receive traffic on the server, the domain name will have to exist, and the
   a record will have to point to this web server in order for this to work.
   You will need to have some website files installed in the directories that
   we have created. You could copy the default web page file into those
   directories as a test.

   This only scratches the surface of how to configure Apache. 
