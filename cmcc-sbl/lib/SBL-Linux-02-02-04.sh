#!/bin/sh
#
#  文件系统-查找未授权的SUID/SGID文件
#  用下面的命令查找系统中所有的SUID和SGID程序，执行：
#  for PART in `grep -v ^# /etc/fstab | awk '($6 != ""0"") {print $2 }'`; do
#    find $PART \( -perm -04000 -o -perm -02000 \) -type f -xdev -print
#  done
#  
#  若存在未授权的文件，则低于安全要求；
#  
#  需要手工检查。
#  
#  补充操作说明：
#  建议经常性的对比suid/sgid文件列表，以便能够及时发现可疑的后门程序
#
#find_suid() {
SBL_Linux_02_02_04() {
  echo "Clearing suid/sgid from Blacklist ..."
  Blacklist="/usr/libexec/utempter/utempter \
             /usr/libexec/polkit-1/polkit-agent-helper-1 \
             /usr/libexec/pt_chown \
             /usr/libexec/kde4/kdesud \
             /usr/bin/Xorg \
             /sbin/netreport  \
             /usr/sbin/userhelper \
             /usr/lib64/vte/gnome-pty-helper
            "
  for list in `find $Blacklist -xdev \( -perm -04000 -o -perm -02000 \) -type f`
  do
    chmod -v ugo-s "$list"
  done
  echo -n "Clear Blacklist OK: "
  success
  echo
  echo "Other suid/sgid file: "
  find / -xdev \( -perm -04000 -o -perm -02000 \) -type f -ls | tee ./backup/suid-sgid.txt.`date +"%s"`
  echo
}
