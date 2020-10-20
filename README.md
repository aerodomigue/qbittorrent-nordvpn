![Build docker image and push](https://github.com/aerodomigue/qbittorrent-nordvpn/workflows/Build%20docker%20image%20and%20push/badge.svg)   
![Daily build and push](https://github.com/aerodomigue/qbittorrent-nordvpn/workflows/Daily%20build%20and%20push/badge.svg)


# docker-qbittorrent-nordvpn
Combines latest linuxserver/qbittorrent with nordvpn and script from wizz752, daily build from latest linuxserver/qbittorrent and nordvpn-cli


# Use docker compose to deploy
```
version: '3'
services:
  qbittorrent-nordvpn:
        image: aerodomigue/qbittorrent-nordvpn:latest
        container_name: qbittorrent-nordvpn
        restart: unless-stopped
        cap_add:
          - NET_ADMIN                       # Required
          - SYS_MODULE                      # Required for TECHNOLOGY=NordLynx
        devices:
          - /dev/net/tun                    # Required
        ports:
          - 8080:8080
          - 6882:6881
          - 6882:6881/udp
        volumes:
          - /media/config:/config
          - /media/torrents:/torrents
          - /media/downloads:/downloads
        environment:
          - TZ=Europe/Paris
          - PGID=1000
          - PUID=1000
          - WEBUI_PORT=8080
          - USER=USERNAME                   # Required
          - PASS=PASSWORD                   # Required
          - TECHNOLOGY=NordLynx
          - CONNECT=--group p2p France
          - KILL_SWITCH=on                  # on|custom|off
          - PORTS=8080
```
