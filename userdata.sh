#!/bin/bash
# UserData script for installing and configuring WordPress on an EC2 instance

# Update the package repository
sudo yum update -y

# Install Apache web server
sudo yum install httpd -y

# Start Apache and configure it to start on boot
sudo systemctl start httpd
sudo systemctl enable httpd

# Install PHP and required modules
sudo yum install php php-mysql -y

# Install MySQL/MariaDB
sudo yum install mariadb-server -y

# Start MySQL/MariaDB and configure it to start on boot
sudo systemctl start mariadb
sudo systemctl enable mariadb

# Secure MySQL installation
sudo mysql_secure_installation <<EOF

y
#Wordpress!1337
#Wordpress!1337
y
y
y
y
EOF

# Create a MySQL database for WordPress
sudo mysql -u root -p"#Wordpress!1337" <<MYSQL_SCRIPT
CREATE DATABASE wordpress;
CREATE USER 'wpuser'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'localhost';
FLUSH PRIVILEGES;
EXIT
MYSQL_SCRIPT

# Install WordPress
sudo yum install wget -y
sudo wget https://wordpress.org/latest.tar.gz
sudo tar -xzvf latest.tar.gz
sudo cp -r wordpress/* /var/www/html/
sudo chown -R apache:apache /var/www/html/
sudo chmod -R 755 /var/www/html/

# Configure WordPress
sudo mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
sudo sed -i 's/database_name_here/wordpress/g' /var/www/html/wp-config.php
sudo sed -i 's/username_here/wpuser/g' /var/www/html/wp-config.php
sudo sed -i 's/password_here/password/g' /var/www/html/wp-config.php

# Restart Apache to apply changes
sudo systemctl restart httpd
