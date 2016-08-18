#!/bin/sh
#
#  文件系统-重要目录和文件的权限设置
#  "执行以下命令检查目录和文件的权限设置情况：
#  ls  -l  /etc/passwd
#  ls  -l  /etc/shadow
#  ls  -l  /etc/group
#  ls  -l  /etc/rc.d/init.d/
#  ls  -l  /etc/
#  ls  -l  /tmp
#  ls  -l  /etc/inetd.conf
#  ls  -l  /etc/security
#  ls  -l  /etc/services
#  ls  -l  /etc/rc*.d
#  "
#  "若权限过低，则低于安全要求；
#  
#  补充操作说明：
#  对于重要目录，建议执行如下类似操作：
#  # chmod -R 750 /etc/rc.d/init.d/*
#  这样只有root可以读、写和执行这个目录下的脚本。
#  "

#chmod_initd() {
SBL_Linux_02_02_03() {
  echo -n "chmod init.d to 750: "
  for file in `find /etc/rc.d/init.d/ -type f -perm /o=rwx`
  do
    chmod -v o-rwx $file || { failure; echo; exit; }
  done

  local lists="/etc/passwd /etc/shadow /etc/group /etc/inetd.conf /etc/security /etc/services"
  for file in `find $lists -type f -perm /o=wx 2>/dev/null`
  do
    echo $file
    chmod -v o-wx $file 2>/dev/null || { failure; echo; exit; }
  done

  success
  echo
}
