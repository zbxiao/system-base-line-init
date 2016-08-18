#!/bin/sh
#
#  帐号与口令-root用户远程登录限制
#  执行：more /etc/securetty，检查Console参数
#  建议在/etc/securetty文件中配置：CONSOLE = /dev/tty01
#
#  *该基线是有问题的*
#    该文件是限制root从何处登录的。从man securetty可看到，
#    每行是一个不包含 /dev/ 的设备文件，console就是对应 /dev/console 了
#    该文件内容的语法是没有 等号 的。
#    其实是想在kernel的启动参数里加入 CONSOLE=/dev/tty01 ？

#set_securetty() {
SBL_Linux_02_01_04() {
  cp /etc/securetty ./backup/securetty_`date +"%s"`
  sed 's/console.*/console = \/dev\/tty01/' /etc/securetty -i
}
