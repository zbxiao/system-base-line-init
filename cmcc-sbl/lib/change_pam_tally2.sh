#!/bin/sh
#
#  对于采用静态口令认证技术的设备，应配置当用户连续认证失败次数超过6次，锁定该用户使用的帐号。
#  /etc/pam.d/system-auth文件中是否对pam_tally.so的参数进行了正确设置。
#  "设置连续输错6次密码，帐号锁定5分钟，
#  使用命令“vi /etc/pam.d/ system-auth”修改配置文件，添加
#  auth required pam_tally.so onerr=fail deny=10 unlock_time=300
#  注：解锁用户 faillog  -u  <用户名>  -r"
#

#change_pam_tally() {
change_pam_tally2() {
  echo -n "Change pam_tally2.so:"
  cp /etc/pam.d/system-auth ./backup/tally-system-auth_`date +"%s"`
  sed -i '/pam_tally2.so onerr=fail deny/d' /etc/pam.d/system-auth
  sed -i \
      's/^\(auth.*required.*\)pam_deny.so/\1pam_tally2.so onerr=fail deny=6 unlock_time=300\n&/' \
      /etc/pam.d/system-auth
  grep "deny=6 unlock_time=300" /etc/pam.d/system-auth >/dev/null 2>&1 && success; echo ||failure;echo
}
