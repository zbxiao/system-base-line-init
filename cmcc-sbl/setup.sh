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

# Call lib/*sh
change_services
custom_history
kill_gdm
other
set_sysctl
SBL_Linux_02_01_01
SBL_Linux_02_01_02
SBL_Linux_02_01_03
SBL_Linux_02_01_04
SBL_Linux_02_01_05
SBL_Linux_02_01_06
SBL_Linux_02_02_01
SBL_Linux_02_02_02
SBL_Linux_02_02_03
SBL_Linux_02_02_04
SBL_Linux_02_02_05
SBL_Linux_02_02_06
SBL_Linux_02_02_07
SBL_Linux_02_02_08
SBL_Linux_02_02_09
SBL_Linux_02_02_11
SBL_Linux_04_01_01
SBL_22
SBL_23
SBL_26_C15
issues_1242_805
