#!/bin/sh

case $1 in
	'start')
		if [ -z != "$2" ]; then
			if [ -z != "$3" ]; then
				/bin/consul agent -pid-file /var/run/consul.pid --config-dir="/etc/consul.d/$3" -join $2 &
			else
				/bin/consul agent -pid-file /var/run/consul.pid --config-dir="/etc/consul.d" -join $2 &
			fi
		else
			echo "Usage: $0 start <consul-ip> [color]" >&2
		fi
	;;
	'stop')
		if [ -z != $(cat /var/run/consul.pid) ]; then
			kill -15 $(cat /var/run/consul.pid)
		else
			echo "Consul pid could not be loaded. Consul is likely already stopped."
		fi
	;;
	*)
		echo "Usage: $0 start <consul-ip> [color]" >&2
		exit 1
	;;
	esac
exit 0
