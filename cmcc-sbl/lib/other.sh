#!/bin/bash
other() {
  # disable selinux
  sed -i '/^SELINUX=/s/.*/SELINUX=disabled/' /etc/selinux/config

  # set start level 3
  grep -q 'id:5' /etc/inittab && sed -i '/^id:/s/5/3/' /etc/inittab
}
