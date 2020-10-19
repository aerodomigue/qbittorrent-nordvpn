#!/bin/bash

# reconnect nordvpn
nordvpn connect ${CONNECT}
status=$?

# restart qbitorrent
pkill -9 qbittorrent-nox

# return nordvpn connection status
exit $status
