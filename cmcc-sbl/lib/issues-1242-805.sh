#!/bin/sh
#
# 检查项名称：检查主机访问控制（IP限制）
# 判断条件：cat /etc/hosts.allow
# all:192.168.4.44:allow #允许单个IP访问所有服务进程
# sshd:192.168.1.:allow  #允许192.168.1的整个网段访问SSH服务进程
#
# #vi /etc/hosts.deny
# all:all:DENY
# 存在类似上述配置则符合安全要求，否则低于安全要求。

issues_1242_805() {
  echo -n "set hosts access(tcp_wapper): "

  cp /etc/hosts.allow ./backup/hosts.allow.`date +"%s"`
  cp /etc/hosts.deny  ./backup/hosts.deny.`date +"%s"`
  allow=`egrep -iw "sshd|telnet|vsftpd|all" /etc/hosts.allow 2>/dev/null | wc -l`
  deny=` egrep -iw "sshd|telnet|vsftpd|all" /etc/hosts.deny  2>/dev/null | wc -l`

  if [ $allow -le 0 ];then
cat<<\EOF >>/etc/hosts.allow
sshd:127.0.0.1:allow

sshd:10.46.169.110:allow
sshd:10.46.170.164:allow
sshd:10.46.170.166:allow
sshd:10.46.170.201:allow
sshd:10.46.198.8:allow
sshd:10.46.198.9:allow
sshd:10.46.204.192/255.255.255.192:allow
EOF
  fi
  if [ $deny -le 0 ];then
    echo 'all:all:deny' >> /etc/hosts.deny
  fi

  allow=`egrep -iw "sshd|telnet|vsftpd|all" /etc/hosts.allow 2>/dev/null | wc -l`
  deny=` egrep -iw "sshd|telnet|vsftpd|all" /etc/hosts.deny  2>/dev/null | wc -l`

  if [ $allow -gt 0 -a $deny -gt 0  ];then
    success
    echo
  else
    failure
    echo
    exit 127;
  fi
}
