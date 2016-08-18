#!/bin/sh
kill_gdm() {
  local PID
  PIDS=`ps auxf|awk '/[g]dm-binary/{print $2}'`
  PIDS="$PIDS `ps auxf|awk '/[p]ulseaudio/{print $2}'`"

  for PID in $PIDS
  do
   [ "x${PID}" != "x" ] && [ -f /proc/${PID}/cmdline ] && kill ${PID}
  done
  unset PID
}
