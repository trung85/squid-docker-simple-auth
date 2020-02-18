squid-docker-simple-auth
========================

A simple (and fragile) Dockerfile for launching an authenticated squid proxy.

The user must specify authentication credentials via the following environment variables:

```
SQUID_USERNAME=foo
SQUID_PASSWORD=bar
```

An example invocation would be:

```
docker run -e SQUID_USERNAME=foo -e SQUID_PASSWORD=bar -p 3128:3128 minhtrung/squid-docker-authenticated
```

How To Set Up & Install Squid Proxy Server On Ubuntu 18.04

https://phoenixnap.com/kb/setup-install-squid-proxy-server-ubuntu

```
Add Squid ACL
  This will create a rule that only allows the system at this IP address to connect. It is recommended that you comment the line to identify the rule:

  acl localnet src 192.168.0.15 # test computer
  Anything after the # sign is ignored by Squid.

  You can specify a range of IP addresses as follows:

  acl localnet src 192.168.0.15/30


```

Open Ports

To open a specific port, add the following:

acl Safe_ports port 123 # Custom port
Configure Proxy Authentication
This forces users to authenticate to use the proxy.

Start by installing apache2-utils:

sudo apt-get install apache2-utils
Create a passwd file, and change the ownership to the Squid user proxy:

sudo touch /etc/squid/passwd
sudo chown proxy: etc/squid/passwd
Add a new user and password
1. To add a new user to Squid, use the command:

sudo htpasswd /etc/squid/passwd newuser
The system will prompt you to enter and confirm a password for newuser.

2. Edit the /etc/squid/squid.conf file, and add the following command lines:

auth_param basic program /usr/lib64/squid/basic_ncsa_auth /etc/squid/passwd

auth_param basic children 5

auth_param basic realm Squid Basic Authentication

auth_param basic credentialsttl 2 hours

acl auth_users proxy_auth REQUIRED

http_access allow auth_users
Block Websites on Squid Proxy
1. Create and edit a new text file /etc/squid/blocked.acl by entering:

sudo nano /etc/squid/blocked.acl
2. In this file, add the websites to be blocked, starting with a dot:

.facebook.com

.twitter.com

Note: The dot specifies to block all subsites of the main site.

3. Open the /etc/squid/squid.conf file again:

sudo nano /etc/squid/squid.conf
4. Add the following lines just above your ACL list:

acl blocked_websites dstdomain “/etc/squid/blocked.acl”
http_access deny blocked_websites
Commands When Working with the Squid Service
To check the status of your Squid software, enter:

sudo systemctl status squid
This will tell you whether the service is running or not.

To start the service enter:

sudo systemctl start squid
Then set the Squid service to launch when the system starts by entering:

sudo systemctl enable squid
You can re-run the status command now to verify the service is up and running.

To stop the service, use the command:

sudo systemctl stop squid
To prevent Squid from launching at startup, enter:

sudo systemctl disable squid
