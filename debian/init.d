#!/bin/sh
### BEGIN INIT INFO
# Provides:          sleepi-utils
# Required-Start:    
# Required-Stop:     umountroot
# Should-Stop:       
# Default-Start:     
# X-Start-Before:    
# Default-Stop:      0 6
# Short-Description: slee-Pi utilities
# Description:       slee-Pi utility tools package
### END INIT INFO

# Author: Masahiro Honda <honda@mechatrax.com>

# Do NOT "set -e"

# PATH should only include /usr/* if it runs after the mountnfs.sh script
PATH=/sbin:/usr/sbin:/bin:/usr/bin
DESC="sleepi-utils"
NAME=sleepi-utils
PROG=/usr/sbin/sleepictl
HWCLOCK=/sbin/hwclock
SCRIPTNAME=/etc/init.d/$NAME

# Exit if the package is not installed
[ -x $PROG ] || exit 0
[ -x $HWCLOCK ] || exit 0

# Read configuration variable file if it is present
[ -r /etc/default/$NAME ] && . /etc/default/$NAME
for var in `grep "^[^#].*=" /etc/default/$NAME | cut -d= -f1`
do
	export $var
done

# Load the VERBOSE setting and other rcS variables
. /lib/init/vars.sh

# Define LSB log_* functions.
# Depend on lsb-base (>= 3.2-14) to ensure that this file is present
# and status_of_proc is working.
. /lib/lsb/init-functions

sleepiclock()
{
	[ "$HCTOSYS" != yes ] && return 0

	case "$1" in
	  start)
		[ "$VERBOSE" != no ] && log_daemon_msg "Starting $DESC" "$NAME"
		$HWCLOCK -s
		case "$?" in
			0|1) [ "$VERBOSE" != no ] && log_end_msg 0 ;;
			2) [ "$VERBOSE" != no ] && log_end_msg 1 ;;
		esac
		;;
	  stop|reload|restart|force-reload)
		[ "$VERBOSE" != no ] && log_daemon_msg "Stopping $DESC" "$NAME"
		$HWCLOCK -w
		case "$?" in
			0|1) [ "$VERBOSE" != no ] && log_end_msg 0 ;;
			2) [ "$VERBOSE" != no ] && log_end_msg 1 ;;
		esac
		;;
	  status)
		$HWCLOCK -r && return 0 || return $?
		;;
	  *)
		echo "Usage: $SCRIPTNAME {start|stop|status|restart|reload|force-reload}" >&2
		return 3
		;;
	esac
}

sleepiclock "$@"

:
