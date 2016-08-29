#!/bin/sh
#
#  对于采用静态口令认证技术的设备，应配置设备，使用户不能重复使用最近5次（含5次）内已使用的口令。
#  
#  检查操作：
#  1、检查不能复用的密码个数
#      执行cat  /etc/pam.d/passwd命令，
#      输出结果：查看以下内容：
#  password required pam_unix.so remember=5 use_authtok md5 shadow
#  
#  检查操作：
#  1、检查不能复用的密码个数
#      执行cat  /etc/pam.d/passwd命令，
#      输出结果：查看以下内容：
#  password required pam_unix.so remember=5 use_authtok md5 shadow
#  
#  *更新*
#  1.对于采用静态口令认证技术的设备，应配置设备，使用户不能重复使用最近5次（含5次）内已使用的口令。
#  参考配置操作：
#      编辑/etc/pam.d/passwd文件：
#  password required pam_unix.so remember=5 use_authtok md5 shadow
#  按该项配置将导致用户修改密码，输入当前密码时出错，提示如下：
#  passwd:Authentication token manipulation error。
#  正确配置：password sufficient pam_unix.so remember=5 use_authtok md5 shadow 
#默认为remember=1

change_pam_unix_remember() {
  local file="/etc/pam.d/system-auth"
  echo -n "Change pam unix: remember=5 "

  cp $file ./backup/unix-system-auth.`date +"%s"`
  remember=`grep '^password.*sufficient.*pam_unix.so' $file`

  if ! echo "$remember" | grep remember >/dev/null;then
    sed -i 's/^\(password.*sufficient.*pam_unix.so\).*/& remember=5/' $file
  fi

  remember=`grep '^password.*sufficient.*pam_unix.so' $file`
  if ! echo "$remember" | grep 'remember=5' >/dev/null;then
     failure
     echo
     exit 127;
  else
    success
    echo
  fi
}
