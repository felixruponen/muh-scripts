#/bin/bash
#
# A simple script to route all traffic from my work VPN to ETH_IFACE to be used by other nodes
# No bridging is used, dnsmasking to simulate DHCP instead
# Iptables need updating as that rule doesn't feel secure at all

ETH_IFACE=enx0050b68b1885

ip addr show ppp0 &> /dev/null
[ $? -eq 0 ] || { echo "no ppp0 device available"; exit 1; }
ip addr show $ETH_IFACE &> /dev/null
[ $? -eq 0 ] || { echo "no eth1 card available"; exit 1; }

[ $UID -eq 0 ] || { echo "you're not a root"; exit 1; }

echo "Fixing the interface"
ip addr add 192.168.117.1/24 dev $ETH_IFACE
ip link set $ETH_IFACE up

echo "Setting up dnsmasq"
dnsmasq -u dnsmasq -r /etc/resolv.conf --bogus-priv --domain-needed --interface=$ETH_IFACE --dhcp-range=192.168.117.10,192.168.117.100,12h

echo "Fixing iptables"
iptables -t nat -A POSTROUTING -o ppp0 -j MASQUERADE

echo "Done!"
