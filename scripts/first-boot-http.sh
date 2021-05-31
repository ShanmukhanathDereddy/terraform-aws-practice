#!/bin/bash

echo "Hello World! Welcome to Terraform "

sudo yum -y update
sudo yum -y install httpd
sudo systemctl start httpd
sudo systemctl enable httpd
