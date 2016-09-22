#!/bin/sh
#
#  对SSH服务进行安全检查
#  
#  使用命令“cat /etc/ssh/sshd_config”查看配置文件
#    （1）检查是否允许root直接登录：
#  检查“PermitRootLogin ”的值是否为no
#    （2）检查SSH使用的协议版本：
#  检查“Protocol”的值
#  
#  使用命令“vi /etc/ssh/sshd_config”编辑配置文件
#    （1）不允许root直接登：
#  设置“PermitRootLogin ”的值为no
#    （2）修改SSH使用的协议版本：
#  设置“Protocol”的版本为2
#  
#  补充说明：
#  root用户需要使用普通用户远程登录后su进行系统管理"

#PermitRootLogin no 改为PermitRootLogin without-password
#without-password allows root login only with public key authentication. 

#set_sshd() {
set_sshd() {
  cp /etc/ssh/sshd_config ./backup/sshd_config.`date +"%s"`
  echo -n "SSHD disable root login and only ssh v2 Protocol: "

  version=`awk '/^Protocol/{print $2}' /etc/ssh/sshd_config`
  PermitRootLogin=`awk '/^PermitRootLogin/{print $2}' /etc/ssh/sshd_config`

  if [ "x$version" == "x" ];then
    echo 'Protocol 2'         >> /etc/ssh/sshd_config
  fi
  if [ "x$PermitRootLogin" == "x" ];then
    #echo 'PermitRootLogin no' >> /etc/ssh/sshd_config
    echo 'PermitRootLogin without-password' >> /etc/ssh/sshd_config
  fi

  version=`awk '/^Protocol/{print $2}' /etc/ssh/sshd_config`
  PermitRootLogin=`awk '/^PermitRootLogin/{print $2}' /etc/ssh/sshd_config`
  if [ "x$version" != "x2" -o "x$PermitRootLogin" != "xwithout-password" ]; then
    sed -i -e 's/^\(Protocol\).*/\1 2/' \
           -e 's/^\(PermitRootLogin\).*/\1 without-password/' /etc/ssh/sshd_config
  fi

  version=`awk '/^Protocol/{print $2}' /etc/ssh/sshd_config`
  PermitRootLogin=`awk '/^PermitRootLogin/{print $2}' /etc/ssh/sshd_config`
  if [ "x$version" != "x2" -o "x$PermitRootLogin" != "xwithout-password" ]; then
     failure
     echo
     exit 127;
  else
     success
     echo
  fi
}
