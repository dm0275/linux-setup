#!/usr/bin/env bash
echo "THIS IS ONLY INTENDED FOR *BUNTU 14.04.* distribution!"
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root!" 1>&2
   exit 1
fi
USER=`grep 1000 /etc/passwd | cut -f1 -d:`

INTELLIJ_VERSION='ideaIU-2016.2.1'

PCK1='php perl git'
PCK2='remmina vlc apache2'
PCK3='ruby1.9.3 curl'

echo "alias untar='tar -xzvf'" >> /home/$USER/.profile
echo "alias tr='tree -A'" >> /home/$USER/.profile

apt-get update
add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe restricted multiverse" -y
apt-get update
apt-get upgrade -y
apt-get install $PCK1 $PCK2 $PCK3 -y

# oracle java
add-apt-repository ppa:webupd8team/java -y
apt-get update
apt-get install oracle-java8-installer -y
apt-get install oracle-java6-installer -y
export JAVA_HOME=/usr/lib/jvm/java-6-oracle/
export IDEA_JDK=/usr/lib/jvm/java-8-oracle/

add-apt-repository ppa:webupd8team/sublime-text-3 -y
apt-get update
apt-get install sublime-text -y

mkdir /opt/software

mkdir /home/$USER/public_html/
ln -s /usr/share/phpmyadmin /home/$USER/public_html/
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

cd /tmp
wget http://apache.spinellicreations.com/maven/maven-3/3.1.1/binaries/apache-maven-3.1.1-bin.tar.gz
tar -xzvf apache-maven-3.1.1-bin.tar.gz
mv apache-maven-3.1.1 /opt/software/apache-maven
export MVN_HOME=/opt/software/apache-maven/
export PATH=/opt/software/apache-maven/bin:$PATH

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb 
dpkg -i google-chrome-stable_current_amd64.deb
apt-get install -f -y

echo "Please reboot now by entering 'sudo reboot'"
exit 0
