cat inputdhcprange.txt >> /etc/dhcp/dhcpd.conf

systemctl restart isc-dhcp-server