# Jenkins Setup Guide

*The guide is specifically for Ubuntu Server.*

First of all, set up a working VM and `ssh` into it.

Install the needed packages:

```bash
sudo apt install fontconfig openjdk-17-jre
```

Make sure that Java was installed properly:

```bash
java -version
```

To set up the keyring (?) to download Jenkins:

```bash
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
```

Add the repository to your server:

```bash
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
/etc/apt/sources.list.d/jenkins.list > /dev/null
```

Install Jenkins:

```bash
sudo apt update
sudo apt install jenkins
```

Connect to it with your web browser via port 8080:

```bash
ip a # enter <ip>:8080 in your web browser
```

Get the password from the file:

```bash
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

Next choose `Install suggested plugins` (Recommended), let it finish.

Set up the credentials or skip this step.

You can add your domain name at the `Instance Configuration` step or leave it
as is. The next steps are simple.

### Setting Up a Jenkins 

Create a VM instance for the agent. Install Java again and confirm that it's
installed:

```bash
sudo apt install fontconfig openjdk-17-jre
java -version
```

- On the main Jenkins page, click on `Set up an agent` 
- Give it a random name
- Tick the permanent agent option
- Ignore the `Remote directory is mandatory` message
- Click on `Save`
- Click on the `random_name` name

Run the commands from the opened page:

```bash
# copy the agent.jar file
curl -sO http://<IP>:8080/jnlpJars/agent.jar
# create a temporary directory and give it `777` permissions. 
# THESE PERMISSIONS SHOULD BE USED EXCLUSIVELY FOR TESTING
# DO NOT USE THEM IN THE PRODUCTION ENVIRONMENT
sudo mkdir /var/jenkins
sudo chmod 777 /var/jenkins
# run the second command
java -jar agent.jar -url http://<IP>:8080/ -secret <secret> -name \ 
"<your_node>" -workDir "/var/jenkins"
```

The agent should now be connected.

Every time you want the agent to be running, you have to run it manually.
First, delete the directory you created manually:

```bash
rm -rf /var/jenkins
```

Create a system user for the Jenkins Agent:

```bash
sudo useradd -r -md /var/jenkins_home -s /bin/bash jenkins
# check that everything worked
cat /etc/passwd # new user
ls -l /var # home directory
```

Update permissions on the Jenkins home directory:

```bash
chown jenkins:jenkins -R /var/jenkins_home
```

Create a new directory, move the agent file there, and give the directory
correct permissions:

```bash
sudo mkdir -p /usr/local/jenkins-service
sudo mv agent.jar /usr/local/jenkins-service/
ls -l /usr/local/jenkins-service
sudo chown jenkins:jenkins -R /usr/local/jenkins-service
ls -l /usr/local/jenkins-service
```

Create a startup script:

```bash
sudo vim /usr/local/jenkins-service/start-agent.sh
```
```bash
#!/bin/bash

cd /usr/local/jenkins-service
curl -sO http://10.10.10.205:8080/jnlpJars/agent.jar
java -jar agent.jar -url http://<IP>:8080/ -secret <secret> -name \ 
"<your_node>" -workDir "/var/jenkins"
exit 0
```

Make the script executable:

```bash
sudo chmod +x /usr/local/jenkins-service/start-agent.sh
```

Next create the systemd unit file to start the agent automatically:

```bash
sudo vim /etc/systemd/system/jenkins-agent.service
```

```bash
[Unit]
Description=Jenkins Agent

[Service]
User=jenkins
WorkingDirectory=/var/jenkins_home
ExecStart=/bin/bash /usr/local/jenkins-service/start-agent.sh
Restart=always

[Install]
WantedBy=multi-user.target
```

Refresh systemd and start the agent:

```bash
sudo systemctl daemon-reload
sudo systemctl enable --now jenkins-agent.service # enable & start
sudo systemctl start jenkins-agent.service # enable & start
```

It should now start automatically :)
