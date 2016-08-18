#!/bin/sh
#
#  帐号与口令-用户的umask安全配置
#  "执行：
#  more /etc/profile  
#  more /etc/csh.login  
#  more /etc/csh.cshrc  
#  more /etc/bashrc
#  检查是否包含umask值且umask=027
#  umask值是默认的，则低于安全要求
#
#  补充操作说明：
#  建议设置用户的默认umask=027

#set_umask() {
SBL_Linux_02_02_02() {
  cp /etc/profile \
     /etc/csh.login \
     /etc/csh.cshrc \
     /etc/bashrc ./backup/
  sed -i 's/^\(\s*umask\).*/\1 027/' \
     /etc/profile /etc/csh.login /etc/csh.cshrc /etc/bashrc

   echo -n $"Set umask to 027: "
   for file in /etc/profile /etc/csh.login /etc/csh.cshrc /etc/bashrc
   do
     for num in `awk '/^ *umask/{print $2}' $file`
     do
        if [ "x$num" != "x027" ] ;then
          failure
          echo
          exit 127
        fi
     done
   done

   success
   echo
}
