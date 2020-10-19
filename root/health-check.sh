#!/bin/bash

state=$(curl -m 10 -s https://api.nordvpn.com/vpn/check/full | jq -r '.["status"]')

if [ "$state" != "Protected" ]; then
	# reconnect and return healthcheck code (0 health, 1 unhealthy)
	/reconnect.sh || exit 1
fi

exit 0
