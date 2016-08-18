#!/bin/sh
#
#  文件系统-查找任何人都有写权限的文件
#  在系统中定位任何人都有写权限的文件用下面的命令：
#
#    for PART in `grep -v ^# /etc/fstab | awk '($6 != ""0"") {print $2 }'`; do
#      find $PART -xdev -type f \( -perm -0002 -a ! -perm -1000 \) -print
#    done
#
#  若返回值非空，则低于安全要求；
#
#find_any_write_file() {
SBL_Linux_02_02_06() {
  echo -n "Find anybody write file: "
  local i=0
  for PART in `awk '/ext(2|3|4)/{print $2}' /etc/fstab`
  do
    for file in `find $PART -xdev -type f \( -perm -0002 -a ! -perm -1000 \)`
    do
      [ $i -eq 0 ] && echo && let i+=1
      chmod -v o-w "$file"
    done
  done

  success
  echo
}
