#!/bin/sh
#  
#  设备应配置日志功能，记录对与设备相关的安全事件。	"检查操作：
#      执行：cat /etc/syslog.conf
#      输出结果：查看以下内容
#      *.err        /var/log/errors
#      authpriv.info    /var/log/authpriv_info
#      *.info        /var/log/info
#      auth.none     /var/log/auth_none
#  
#      执行以下命令：
#      #more /var/log/errors
#      #more /var/log/authpriv_info
#      #more /var/log/info
#      #more /var/log/auth_none
#  输出结果：查看/var/log/errors，/var/log/messages，查看安全事件审计情况。
#  
#  备注：有返回结果则表示安全事件审计正常，符合安全要求

# 只新增一个errors即可：
#rsyslog_add_err() {
SBL_23() {

  local file="/etc/rsyslog.conf"
  cp $file ./backup/rsyslog.conf.`date +"%s"`

  echo -n "rsyslog add errors: "

  if ! grep 'log/errors' $file >/dev/null;then
    sed -i 's@^local7\.\*\(.*log/\)boot.log@&\n*.err   \1errors@' $file
  fi

  if ! grep 'log/errors' $file >/dev/null;then
     failure
     echo
     exit 127;
  else
    success
    echo
  fi
}
