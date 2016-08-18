#!/bin/sh
#
#  帐号与口令-检查是否存在除root之外UID为0的用户
#  执行：awk -F: '($3 == 0) { print $1 }' /etc/passwd
#  "返回值包括“root”以外的条目，则低于安全要求；
#
#  补充操作说明：
#  UID为0的任何用户都拥有系统的最高特权，保证只有root用户的UID为0

#check_uid() {
SBL_Linux_02_01_05() {
  echo -n $"Checking UID: "

  for user in `awk -F: '($3 == 0) { print $1 }' /etc/passwd`
  do
    [ "$user" == "root" ] && continue
    failure
    echo
    exit 127
  done

  success
  echo
}
