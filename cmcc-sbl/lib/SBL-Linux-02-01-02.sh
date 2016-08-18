#!/bin/sh
#
#  对于采用静态口令认证技术的设备，口令长度至少8位，并包括数字、小写字母、大写字母和特殊符号4类中至少3类。
#    英语大写字母 A, B, C, … Z 
#    英语小写字母 a, b, c, … z 
#    西方阿拉伯数字 0, 1, 2, … 9 
#    非字母数字字符，如标点符号，@, #, $, %, &, *等"
#
#  /etc/pam.d/system-auth文件中是否对pam_cracklib.so的参数进行了正确设置。
#
#  检查操作：
#    检查口令策略的配置长度、复杂度安全要求
#      执行：cat /etc/pam.d/passwd命令
#      输出结果：检查类似配置
#  password  requisite pam_cracklib.so minlen=8 ucredit=-1 lcredit=-1 dcredit=-1 ocredit=-1
#  //代表最短密码长度为8,其中至少包含一个大写字母，一个小写字母，一个数字和一个字符"

#change_pam_cracklib() {
SBL_Linux_02_01_02() {
  cp /etc/pam.d/system-auth ./backup/system-auth_`date +"%s"`
  sed -i \
      's/\(pam_cracklib.so\).*/\1 try_first_pass retry=3 difok=3 minlen=8 ucredit=-1 lcredit=-1 dcredit=-1/' \
      /etc/pam.d/system-auth
}
