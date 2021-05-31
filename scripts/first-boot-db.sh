#!/bin/bash

echo "Hello World from terraform"

sudo yum -y update
sudo yum -y install mariadb mariadb-server
sudo systemctl start mysql
sudo systemctl enable mysql