#!/bin/bash

echo 'deb http://eu-west-1.ec2.archive.ubuntu.com/ubuntu/ saucy main' | tee /etc/apt/sources.list
echo 'deb-src http://eu-west-1.ec2.archive.ubuntu.com/ubuntu/ saucy main' | tee -a /etc/apt/sources.list
echo 'deb http://eu-west-1.ec2.archive.ubuntu.com/ubuntu/ saucy-updates main' | tee -a /etc/apt/sources.list
echo 'deb-src http://eu-west-1.ec2.archive.ubuntu.com/ubuntu/ saucy-updates main' | tee -a /etc/apt/sources.list
echo 'deb http://eu-west-1.ec2.archive.ubuntu.com/ubuntu/ saucy universe' | tee -a /etc/apt/sources.list
echo 'deb-src http://eu-west-1.ec2.archive.ubuntu.com/ubuntu/ saucy universe' | tee -a /etc/apt/sources.list
echo 'deb http://eu-west-1.ec2.archive.ubuntu.com/ubuntu/ saucy-updates universe' | tee -a /etc/apt/sources.list
echo 'deb-src http://eu-west-1.ec2.archive.ubuntu.com/ubuntu/ saucy-updates universe' | tee -a /etc/apt/sources.list
echo 'deb http://eu-west-1.ec2.archive.ubuntu.com/ubuntu/ saucy multiverse' | tee -a /etc/apt/sources.list
echo 'deb-src http://eu-west-1.ec2.archive.ubuntu.com/ubuntu/ saucy multiverse' | tee -a /etc/apt/sources.list
echo 'deb http://eu-west-1.ec2.archive.ubuntu.com/ubuntu/ saucy-updates multiverse' | tee -a /etc/apt/sources.list
echo 'deb-src http://eu-west-1.ec2.archive.ubuntu.com/ubuntu/ saucy-updates multiverse' | tee -a /etc/apt/sources.list
echo 'deb http://eu-west-1.ec2.archive.ubuntu.com/ubuntu/ saucy-backports main restricted universe multiverse' | tee -a /etc/apt/sources.list
echo 'deb-src http://eu-west-1.ec2.archive.ubuntu.com/ubuntu/ saucy-backports main restricted universe multiverse' | tee -a /etc/apt/sources.list
echo 'deb http://security.ubuntu.com/ubuntu saucy-security main' | tee -a /etc/apt/sources.list
echo 'deb-src http://security.ubuntu.com/ubuntu saucy-security main' | tee -a /etc/apt/sources.list
echo 'deb http://security.ubuntu.com/ubuntu saucy-security universe' | tee -a /etc/apt/sources.list
echo 'deb-src http://security.ubuntu.com/ubuntu saucy-security universe' | tee -a /etc/apt/sources.list
echo 'deb http://security.ubuntu.com/ubuntu saucy-security multiverse' | tee -a /etc/apt/sources.list
echo 'deb-src http://security.ubuntu.com/ubuntu saucy-security multiverse' | tee -a /etc/apt/sources.list

locale-gen en_US en_US.UTF-8 && dpkg-reconfigure locales

apt-get update
apt-get upgrade -y -q
apt-get dist-upgrade -y -q
apt-get -y -q autoclean
apt-get -y -q autoremove

apt-get install --force-yes -y -q build-essential devscripts curl sudo net-tools git software-properties-common python-software-properties libssl-dev wget ssl-cert bison openssl libreadline6 libreadline6-dev zlib1g zlib1g-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt-dev libreadline6 libreadline6-dev


## clean up so we use less space
apt-get clean
