#
# Create Reverse Lookup for 192.168.1.0
#

$subnet="192.168.1.0/24"

Add-DnsServerPrimaryZone `
-ComputerName $env:COMPUTERNAME `
-NetworkId $subnet `
-ReplicationScope "Forest"

Register-DnsClient