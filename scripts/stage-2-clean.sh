#!/bin/bash
 
yum install -y make automake gcc bz2 wget
 
cd /tmp
wget -c http://download.virtualbox.org/virtualbox/6.1.16/VBoxGuestAdditions_6.1.16.iso -O VBoxGuestAdditions_6.1.16.iso
mount VBoxGuestAdditions_6.1.16.iso -o loop /mnt/
cd /mnt
source /opt/rh/devtoolset-8/enable
bash /mnt/VBoxLinuxAdditions.run --nox11
usermod -aG vboxsf vagrant
cp /opt/VBoxGuestAdditions-6.1.16/other/mount.vboxsf /sbin
cd /tmp
sudo -f rm *.iso
 
 
# clean all
yum update -y
yum clean all
 
 
# Install vagrant default key
mkdir -pm 700 /home/vagrant/.ssh
curl -sL https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub -o /home/vagrant/.ssh/authorized_keys
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh
 
 
# Remove temporary files
rm -rf /tmp/*
rm -f /var/log/wtmp /var/log/btmp
rm -rf /var/cache/* /usr/share/doc/*
rm -rf /var/cache/yum
rm -rf /vagrant/home/*.iso
rm -f ~/.bash_history
history -c
 
rm -rf /run/log/journal/*
 
# Fill zeros all empty space
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
sync
grub2-set-default 0
echo "### Hi from secone stage" >> /boot/grub2/grub.cfg
