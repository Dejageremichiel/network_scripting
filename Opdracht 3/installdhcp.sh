sudo apt install -y isc-dhcp-server

cp /etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf_backup

cp /home/user/bashopdracht/installdhcp.txt /etc/dhcp/dhcpd.conf


cp /etc/default/isc-dhcp-server /etc/default/isc-dhcp-server_backup

echo '
INTERFACESv4="ens192"
#INTERFACESv6=""
' > /etc/default/isc-dhcp-server

systemctl restart isc-dhcp-server