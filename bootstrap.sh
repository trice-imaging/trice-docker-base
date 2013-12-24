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

apt-get install --force-yes -y -q curl sudo net-tools git software-properties-common python-software-properties libssl-dev wget ssl-cert bison openssl libreadline6 libreadline6-dev zlib1g zlib1g-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt-dev libreadline6 libreadline6-dev

cd /usr/local
test -e /usr/local/rbenv || git clone https://github.com/sstephenson/rbenv.git
cat << EOF > /etc/profile.d/rbenv.sh
export PATH="/usr/local/rbenv/bin:\$PATH"
export RBENV_ROOT=/usr/local/rbenv
eval "\$(rbenv init -)"
upgrade_rbenv()
{
        pushd /usr/local/rbenv
        git pull
        popd
        pushd /usr/local/rbenv/plugins/ruby-build
        git pull
        popd
}
EOF

mkdir -p rbenv/plugins
test -e /usr/local/rbenv/plugins/ruby-build || git clone https://github.com/sstephenson/ruby-build.git rbenv/plugins/ruby-build

echo 'export PATH="/usr/local/rbenv/plugins/ruby-build/bin:$PATH"' > /etc/profile.d/ruby-build.sh

cat << EOF > /etc/profile.d/jruby.sh
jruby_client()
{
  export JRUBY_OPTS="--1.9 -J-noverify -Xcompile.invokedynamic=false -J-Dfile.encoding=UTF8 -J-Xms512m -J-Xmx2048m -J-XX:+TieredCompilation -J-XX:TieredStopAtLevel=1 -J-XX:+UseCompressedOops --server"
}

jruby_server()
{
  export JRUBY_OPTS="--1.9 -J-noverify -Xcompile.invokedynamic=false -J-Dfile.encoding=UTF8 -J-Xms512m -J-Xmx4096m -J-XX:+TieredCompilation -J-XX:+UseCompressedOops --server"
}
EOF

chmod +x /etc/profile.d/ruby-build.sh
chmod +x /etc/profile.d/rbenv.sh
chmod +x /etc/profile.d/jruby.sh

## clean up so we use less space
apt-get clean
