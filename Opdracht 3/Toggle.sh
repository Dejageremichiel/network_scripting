#!/bin/sh
while true; do
	read -p "static ip (s), dhcp (d) " ip 
	case $ip in
	[Ss]* ) echo "static ip"
			echo "
			iface lo inet loopback
			auto lo
			
			auto ens192
			iface ens192 inet static
				address 192.168.100.12
				gateway 192.168.100.1
				netmask 255.255.255.0
				network 192.168.100.0
				broadcast 192.168.100.255
			" > /etc/network/interfaces
			echo "restart network"
			sudo systemctl restart networking.service
			
			echo "done"; break;;
	[Dd]* ) echo "dhcp zetten"
			echo "
			iface lo inet loopback
			auto lo
			
			auto ens192
			allow-hotplug ens192
			iface ens192 inet dhcp
			" > /etc/network/interfaces
			echo "restart network"
			sudo systemctl restart networking.service
			echo "done"; exit;;
	esac
done