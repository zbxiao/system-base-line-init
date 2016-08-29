#!/bin/bash
#
#关闭selinux
#
other() {
echo -n "Disable selinux:"
  # disable selinux
  sed -i '/^SELINUX=/s/.*/SELINUX=disabled/' /etc/selinux/config
if [ $? -ne 0 ] ;then
    failure
    echo
else
    success
	echo
fi
  # set start level 3
#  grep -q 'id:5' /etc/inittab && sed -i '/^id:/s/5/3/' /etc/inittab
}
