#!/bin/bash

sudo yum update -y
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
sudo echo '<h1>Hello from Apache Webserver!</h1>' > /var/www/html/index.html