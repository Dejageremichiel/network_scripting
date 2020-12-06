#!/bin/bash
echo 'installatie bind9'
sudo apt install -y bind9

echo 'backup named.conf.local'
cp /etc/bind/named.conf.local /etc/bind/named.conf.local_backup

echo 'instellen named.conf.local'
echo 'zone "michieldejagere.com" {
type master;
file "/etc/bind/zones/michieldejagere.com.db";
};
zone "3.2.1.in-addr.arpa" {
type master;
file "/etc/bind/zones/rev.3.2.1.in-addr.arpa";
};' >> /etc/bind/named.conf.local


mkdir /etc/bind/zones

echo 'instellen en maken bind/zones/michieldejagere.com.db'
echo '$; BIND data file for michieldejagere.com
;
$TTL 14400
@ IN SOA ns1.michieldejagere.com. host.michieldejagere.com. (
201006601 ; Serial
7200 ; Refresh
120 ; Retry
2419200 ; Expire
604800) ; Default TTL
;
michieldejagere.com. IN NS ns1.michieldejagere.com.
michieldejagere.com. IN NS ns2.michieldejagere.com.
 
michieldejagere.com. IN MX 10 mail.michieldejagere.com.
michieldejagere.com. IN A 192.168.100.11
 
ns1 IN A 192.168.100.11
www IN CNAME michieldejagere.com.
mail IN A 192.168.100.11
ftp IN CNAME michieldejagere.com.
michieldejagere.com. IN TXT "v=spf1 ip4:192.168.100.11 a mx ~all"
mail IN TXT "v=spf1 a -all"' > /etc/bind/zones/michieldejagere.com.db

echo '@ IN SOA michieldejagere.com. host.michieldejagere.com. (
2010081401;
28800;
604800;
604800;
86400 );
 
IN NS ns1.michieldejagere.com.
4 IN PTR michieldejagere.com.
' > /etc/bind/zones/rev.3.2.1.in-addr.arpa

echo 'search michieldejagere.com' >> /etc/resolv.conf

/etc/init.d/bind9 restart