#!/bin/bash

pid="$1"

systemctl list-units --type=service | \
	cut -d" " -f1 | \
	while read name
	do
		if [[ "$name" =~ .service$ ]] ; then
			name=$(echo $name | cut -d"." -f1)
		else
			continue  
		fi
		
		if systemctl status $name | grep -E "PID: $pid " 2>&1 > /dev/null
		then
			echo "Service is $name"
			break
		fi
	done
