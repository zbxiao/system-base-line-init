#!/bin/sh
#
#  帐号与口令-root用户环境变量的安全性
#  执行：echo $PATH | egrep '(^|:)(\.|:|$)'，检查是否包含父目录，
#  执行：find `echo $PATH | tr ':' ' '` -type d \( -perm -002 -o -perm -020 \) -ls，检查是否包含组目录权限为777的目录
#
#  返回值包含以上条件，则低于安全要求；
#
#  补充操作说明：
#  确保root用户的系统路径中不包含父目录，在非必要的情况下，不应包含组权限为777的目录
#

#check_path() {
SBL_Linux_02_01_06() {
  local LPATH="$1"

  echo -n $"Checking \$PATH"
  #是否包含父目录
  if ! echo $LPATH | egrep '(^|:)(\.|:|$)' >/dev/null;then
    failure
    echo
    exit 126
  fi
  # 不应包含组权限为777的目录
  for dir in `echo $LPATH | tr ':' ' '`
  do
    [ ! -d $dir ] && continue
    num=`find $dir -type d \( -perm -002 -o -perm -020 \) -ls |wc -l`
    if [ "x$num" != "x0" ];then
        failure
        echo
        echo "===$dir is 777 ==="
        exit 127
    fi
  done

  success
  echo
}
