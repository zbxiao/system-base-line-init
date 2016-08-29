#!/bin/sh
current_dir=`dirname $0`
current_dir=`readlink -f $current_dir`


cd ${current_dir} || exit 127
for i in ./lib/*.sh ; do
    if [ -r "$i" ]; then
        if [ "${-#*i}" != "$-" ]; then
            . "$i"
        else
            . "$i" >/dev/null 2>&1
        fi
    fi
done

loca_path="$PATH"
. /etc/rc.d/init.d/functions
#creat backup directory
ls ./backup > /dev/null 2>&1 ||mkdir ./backup

# Call lib/*sh
change_pam_cracklib
change_pam_tally2
change_pam_unix_remember
change_yum
other
set_iptables
set_limits
set_passwd_expire
set_sysctl
set_tmout
