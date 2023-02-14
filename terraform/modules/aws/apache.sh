#!/bin/bash
#alternative way to install apache servers with user data script

#update repository
sudo apt-get update

#installing Apache server
sudo apt install apache2 php libapache2-mod-php -y

#starting httpd service
sudo systemctl start apache2

#configure Apache to run on startup
sudo systemctl enable apache2

#enabling permissions to create and edit the HTML file
sudo chown -R $USER:$USER /var/www

#creating php
echo "Hello EPAM! My name is Ivan Mospan :)" > /var/www/html/index.php

#enabling index.php as a default page
echo 'DirectoryIndex index.php' > /etc/apache2/mods-enabled/dir.conf

#restart apache2 to enable changes
sudo systemctl restart apache2
