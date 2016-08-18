#!/bin/sh
#
#  帐号与口令-检查登录超时设置
#  使用命令“cat /etc/profile |grep TMOUT”查看TMOUT是否被设置
#  "使用命令“vi /etc/profile”编辑profile配置文件，查找TMOUT，若没有，则在文件最后添加如下语句：
#  TMOUT=180
#  export TMOUT
#  
#  即设置超时时间为3分钟，编辑好文件后，保存，退出，重新登录，设置生效。"
#  *注意*
#  在邮件《关于终端连接操作系统时间的调整》里已更改为600秒

#set_tmout() {
SBL_Linux_02_02_09() {
  cp /etc/profile ./backup/tmout_profile.`date +"%s"`

   echo -n $"Set TMOUT to 600: "
   num=`awk -F'=' '/TMOUT/{print $NF}' /etc/profile`
   if [ "x$num" == "x" ];then
     echo 'export TMOUT=600' >> /etc/profile
   elif [ $num -ne 600 ];then
     sed 's/TMOUT=.*/TMOUT=600/' /etc/profile -i
   fi

   num=`awk -F'=' '/TMOUT/{print $NF}' /etc/profile`
   if [ "x$num" == "x600" ];then
     success
     echo
   else
     failure
     echo
     exit 127;
   fi
}
