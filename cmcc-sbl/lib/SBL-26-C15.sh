#!/bin/sh
#
# 系统在登陆时暴露有关操作系统版本信息
# 
# 分别编辑三个配置文件（/etc/issue、/etc/issue.net、/etc/motd），
# 将操作系统类型及版本号等敏感信息清除，或者替换为严厉警告信息：
# echo 'ONLY Authorized users only! All accesses logged' > /etc/issue
# echo 'ONLY Authorized users only! All accesses logged' > /etc/issue.net
# echo 'ONLY Authorized users only! All accesses logged' > /etc/motd"

#set_issue() {
SBL_26_C15() {
  echo -n "set issue: "

  echo 'ONLY Authorized users only! All accesses logged' > /etc/issue
  echo 'ONLY Authorized users only! All accesses logged' > /etc/issue.net
  echo 'ONLY Authorized users only! All accesses logged' > /etc/motd

  local num=`cat /etc/issue /etc/issue.net /etc/motd | wc -l`
  if [ "x$num" == "x3" ];then
     success
     echo
  else
     failure
     echo
     exit 127;
  fi
}
