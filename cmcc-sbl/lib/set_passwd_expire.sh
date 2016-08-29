#!/bin/sh
#
# 询问管理员是否存在如下类似的简单用户密码配置，比如：
#  root/root, test/test, root/root1234
# 执行：more /etc/login.defs，检查PASS_MAX_DAYS/ PASS_MIN_DAYS/PASS_WARN_AGE参数
# 或执行：cat /etc/login.defs |grep PASS命令查看
# 执行：awk -F: '($2 == """") { print $1 }' /etc/shadow, 检查是否存在空口令帐号"
#
# 建议在/etc/login.defs文件中配置：
# PASS_MAX_DAYS  90        #新建用户的密码最长使用天数
# PASS_MIN_DAYS  0         #新建用户的密码最短使用天数
# PASS_MIN_LEN   8         #新建用户密码的最短长度
# PASS_WARN_AGE  7         #新建用户的密码到期提前提醒天数
# 不存在空口令帐号

#change_pass_days() {
set_passwd_expire() {
echo -n "Set passwd expire:"
#  /usr/bin/chage -M 90 admin
  cp /etc/login.defs ./backup/
  sed -i -e 's/^\(PASS_MAX_DAYS\).*/\1  90/' \
         -e 's/^\(PASS_MIN_DAYS\).*/\1  0/'  \
         -e 's/^\(PASS_MIN_LEN\).*/\1   8/'   \
         -e 's/^\(PASS_WARN_AGE\).*/\1  7/'  \
      /etc/login.defs
if [ $? -ne 0 ] ;then
    failure
    echo
else
	success
	echo
fi
}

