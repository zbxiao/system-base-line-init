#!/bin/sh
#
#  文件系统-检查任何人都有写权限的目录
#  "在系统中定位任何人都有写权限的目录用下面的命令：
#  for PART in `awk '($3 == ""ext2"" || $3 == ""ext3"") \
#  { print $2 }' /etc/fstab`; do
#  find $PART -xdev -type d \( -perm -0002 -a ! -perm -1000 \) -print
#  done"
#  若返回值非空，则低于安全要求；
#
#find_any_write_dir() {
SBL_Linux_02_02_05() {
  echo -n "Find anybody write dir: "
  local i=0
  for PART in `awk '/ext(2|3|4)/{print $2}' /etc/fstab`
  do
    for dir in `find $PART -xdev -type d \( -perm -0002 -a ! -perm -1000 \)`
    do
      [ $i -eq 0 ] && echo && let i+=1
      chmod -v o-w "$dir"
    done
  done

  success
  echo
}
