#!/bin/bash
set_iptables() { 
echo -n "Set /etc/sysconfig/iptables:"
 cat <<EOF  >/etc/sysconfig/iptables 
*filter
:INPUT DROP [0:0]
:FORWARD DROP [0:0]
:OUTPUT ACCEPT [0:0]

-A INPUT -m state --state ESTABLISHED,RELATED,UNTRACKED -j ACCEPT
-A INPUT -p icmp -j ACCEPT
-A INPUT -i lo -j ACCEPT
-A INPUT -i em2 -j ACCEPT

-A INPUT -s 222.76.240.0/24 -j ACCEPT
-A INPUT -s 117.25.157.67 -j ACCEPT
-A INPUT -s 118.26.233.54 -j ACCEPT
-A INPUT -p tcp --dport 80 -j ACCEPT

COMMIT

*raw
:PREROUTING ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
-A PREROUTING -s 127.0.0.1 -j NOTRACK
-A PREROUTING -d 127.0.0.1 -j NOTRACK
-A PREROUTING -s 192.168.1.0/24 -j NOTRACK
-A PREROUTING -d 192.168.1.0/24 -j NOTRACK
-A PREROUTING -p tcp --dport 80 -j NOTRACK

-A OUTPUT -s 127.0.0.1 -j NOTRACK
-A OUTPUT -d 127.0.0.1 -j NOTRACK
-A OUTPUT -s 192.168.1.0/24 -j NOTRACK
-A OUTPUT -d 192.168.1.0/24 -j NOTRACK
-A OUTPUT -p tcp --sport 80 -j NOTRACK
COMMIT
EOF

if [ $? -ne 0 ] ;then
    failure
    echo
else
    success
	echo
fi
}
