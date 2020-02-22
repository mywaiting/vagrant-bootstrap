#!/usr/bin/env bash

# Add the code to Vagrantfile
# config.vm.provision :shell, path: "bootstrap.sh"

echo "--------------------------"
echo "  Hostname & Users        "
echo "--------------------------"

# hostname
echo 'vagrant' > /etc/hostname
hostname -F /etc/hostname

# hosts
echo '127.0.0.1   vagrant' >> /etc/hosts 

# users
# user add example-user



echo "--------------------------"
echo " Upgdate & Upgrade System "
echo "--------------------------"

# change source mirror
mv /etc/apt/sources.list /etc/apt/sources.list.bak
# bash -c "cat /vagrant/sources.list.mirror /etc/apt/sources.list.bak > /etc/apt/sources.list"
bash -c "cat /vagrant/sources.list.mirror > /etc/apt/sources.list"

# apt-get update and upgrade
apt-get update -y
apt-get upgrade -y

# install build tools
apt-get install -y make build-essential
apt-get install -y git curl wget
# for compile python, MUST INSTALL for python env
apt-get install -y libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev libffi-dev libncurses5-dev libcurl4-openssl-dev python-dev 



echo "--------------------------"
echo " Install Redis/MySQL      "
echo "--------------------------"

# install redis-server
# apt-get install -y redis-server 

# mysql-server
# apt-get install -y libmysqlclient-dev mysql-server 

# install postgresql
# apt-get install -y postgresql-server

# mariadb-server
# apt-get install -y mariadb-server

# mysql -u root
# \q
# mysql_secure_installation
# Y for all