#!/bin/bash

rpm -i /home/vagrant/kernel-5.10.0_rc2-1.x86_64.rpm
rpm -i /home/vagrant/kernel-headers-5.10.0_rc2-1.x86_64.rpm
# Remove older kernels (Only for demo! Not Production!)
rm -f /boot/*3.10*
echo "Deleted success."
# Update GRUB
grub2-mkconfig -o /boot/grub2/grub.cfg
grub2-set-default 0
echo "Grub update done."
# Reboot VM
shutdown -r now
