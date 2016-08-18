#!/bin/sh
#
#  帐号与口令-远程连接的安全性配置
#    执行：find  / -name  .netrc，检查系统中是否有.netrc文件，
#    执行：find  / -name  .rhosts ，检查系统中是否有.rhosts文件
#
#  补充操作说明
#    如无必要，删除这两个文件
#    返回值包含以上条件，则低于安全要求；
#
#check_netrc() {
SBL_Linux_02_02_01() {
  echo -n $"checking netrc and rhosts files: "
  local num
  num=`find / -xdev \( -name ".netrc" -o -name ".rhosts" \) | wc -l`
  if [ "x$num" != "x0" ];then
    failure
    echo
    exit 128
  fi
  success
  echo
}
