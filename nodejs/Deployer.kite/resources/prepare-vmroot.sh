#!/bin/bash
update-rc.d -f apache2 remove
update-rc.d -f apparmor remove
rm /etc/resolv.conf
echo "nameserver 8.8.8.8" > /etc/resolv.conf
if [ ! -f /opt/runner ]
then 
  touch /opt/runner && chmod 755 /opt/runner && ln -s /opt/runner /etc/init.d/runner && update-rc.d runner defaults ;
fi