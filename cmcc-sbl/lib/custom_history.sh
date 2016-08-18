#!/bin/bash
custom_history() {
  echo -n "custom history format: "
cat<<\EOF >/etc/profile.d/history.sh
export HISTTIMEFORMAT="[%F %T]"
export HISTSIZE=40960
EOF

  success
  echo
}
