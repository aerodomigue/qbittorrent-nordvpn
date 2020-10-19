FROM linuxserver/qbittorrent:latest

LABEL maintainer="aerodomigue"

HEALTHCHECK --interval=1m --timeout=20s --start-period=1m \
CMD /health-check.sh

RUN addgroup --system vpn && \
    apt-get update && apt-get upgrade -y && \
    apt-get install -y wget dpkg curl gnupg2 jq iptables vim iputils-ping iproute2 ipset xsltproc

RUN nord_vpn_version=$(curl -s https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/ | grep -o ">nordvpn_.*_amd64.deb" | tail -n 1 | egrep -o "([0-9]{1,}\.)+[0-9]{1,}")
RUN { wget -nc https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn_$nord_vpn_version\_amd64.deb && dpkg -i nordvpn_$nord_vpn_version\_amd64.deb } || \
    { wget -nc https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn_$nord_vpn_version\_arm64.deb && dpkg -i nordvpn_$nord_vpn_version\_arm64.deb }
RUN rm -rf \
        ./nordvpn* \
        /tmp/* \
        /var/lib/apt/lists/* \
        /var/tmp/*

# add local files
COPY root/ /
