#!/bin/sh
#
#  系统文件-系统core dump状态
#  
#  执行：more /etc/security/limits.conf 检查是否包含下列项：
#  * soft core 0
#  * hard core 0
#  
#  若不存在，则低于安全要求
#  
#  补充操作说明：
#  core dump中可能包括系统信息，易被入侵者利用，建议关闭

#set_limit() {
SBL_Linux_04_01_01() {
  echo -n "set limit: soft/hard core to 0: "
  local file="/etc/security/limits.conf"
  cp ${file} ./backup/limits.conf.`date +"%s"`

  num_soft=`awk '/^\*.*soft.*core/{print $NF }' $file `
  num_hard=`awk '/^\*.*hard.*core/{print $NF }' $file `

  if [ "x$num_soft" != "x0" ];then
    sed -i 's/^\*.*soft.*core/#&/' $file
    echo '* soft core 0' >> $file
  fi
  if [ "x$num_hard" != "x0" ];then
    sed -i 's/^\*.*hard.*core/#&/' $file
    echo '* hard core 0' >> $file
  fi

  num_soft=`awk '/^\*.*soft.*core/{print $NF }' $file `
  num_hard=`awk '/^\*.*hard.*core/{print $NF }' $file `
  if [ "x$num_soft" == "x0"  ] && [ "x$num_hard" == "x0"  ];then 
     success
     echo
  else
     failure
     echo
     exit 127;
  fi
}
