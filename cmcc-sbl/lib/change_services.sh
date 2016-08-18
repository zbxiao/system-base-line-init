#!/bin/bash
change_services() {

  echo -n "stop servers: "

  # from ZhangXW - 13910725666@139.com
  # turnoff services of no need
  chkconfig="/sbin/chkconfig"
  services=`LANG="en_US.UTF-8" $chkconfig --list | awk '{print $1}'`

  for i in $services
  do
    case $i in
      crond|irqbalance|microcode_ctl|network|sshd|rsyslog|random| \
        lm_sensors|lvm2-monitor|iptables|mdmonitor|readahead_early|smartd| \
        ipmi|iscsi|iscsid|local)
        $chkconfig --level 2345 $i on
        ;;
      *)
        $chkconfig $i off
        /sbin/service $i stop  &>/dev/null
        ;;
    esac
  done

  success
  echo
}
