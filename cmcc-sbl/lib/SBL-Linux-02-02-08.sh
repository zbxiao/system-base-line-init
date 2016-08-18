#!/bin/sh
#
# 文件系统-检查异常隐含文件
# 用“find”程序可以查找到这些隐含文件。例如：
#     # find  / -name "".. *"" -print –xdev
#     # find  / -name ""…*"" -print -xdev | cat -v
#     find  / -xdev -name "..*" -print
#     find  / -xdev -name ".. *" -print 
#     find  / -xdev -name "…*" -print 
#     find  / -xdev -name "...*" -print 
#  同时也要注意象“.xx”和“.mail”这样的文件名的。（这些文件名看起来都很象正常的文件名）
# 若返回值非空，则低于安全要求；
# 
# 补充操作说明
# 在系统的每个地方都要查看一下有没有异常隐含文件（点号是起始字符的，用“ls”命令看不到的文件），
# 因为这些文件可能是隐藏的黑客工具或者其它一些信息（口令破解程序、其它系统的口令文件，等等）。
# 在UNIX下，一个常用的技术就是用一些特殊的名，如：“…”、“..    ”（点点空格）或“..^G”（点点control-G），来隐含文件或目录。"
# 
#find_hidden_files() {
SBL_Linux_02_02_08() {
  echo -n "Find hidden files:"
  local flag=0

  rm -f '/usr/share/man/man1/..1.gz'

  for PART in `awk '/ext(2|3|4)/{print $2}' /etc/fstab`
  do
    for file in `find $PART -xdev \( -name "..*" -o -name ".. *" -o -name "... *" \)`
    do
      [ $flag -eq 0 ] && echo
      let flag+=1
      ls -l "$file"
    done
  done

  if [ $flag -gt 0 ];then
    failure
  else
    success
  fi
  echo
}
