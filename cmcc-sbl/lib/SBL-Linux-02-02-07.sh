#!/bin/sh
#
#  文件系统-检查没有属主的文件
#  定位系统中没有属主的文件用下面的命令：
#  for PART in `grep -v ^# /etc/fstab | awk '($6 != ""0"") {print $2 }'`; do
#  find $PART -nouser -o -nogroup -print
#  done
#  注意：不用管“/dev”目录下的那些文件。
#  
#  若返回值非空，则低于安全要求；
#  
#  补充操作说明
#  发现没有属主的文件往往就意味着有黑客入侵你的系统了。不能允许没有主人的文件存在。
#  如果在系统中发现了没有主人的文件或目录，先查看它的完整性，如果一切正常，给它一个主人。
#  有时候卸载程序可能会出现一些没有主人的文件或目录，在这种情况下可以把这些文件和目录删除掉。"

#find_nouser() {
SBL_Linux_02_02_07(){
  echo -n "Find nouser or nogroup: "
  local flag=0
  for PART in `awk '/ext(2|3|4)/{print $2}' /etc/fstab`
  do
    for file in `find $PART -xdev -nouser -o -nogroup`
    do
      [ $flag -eq 0 ] && echo
      let flag+=1
      ls -l $file
    done
  done

  if [ $flag -gt 0 ];then
    failure
  else
    success
  fi
  echo
}
