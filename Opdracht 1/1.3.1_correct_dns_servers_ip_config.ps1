$Ipaddress_dc2 = "192.168.1.3"

#
# Get physical network adapters : ethernet (802.3)
#
$eth0=Get-NetAdapter -Physical | Where-Object{ $_.PhysicalMediaType -match "802.3" -and $_.Status -eq "up"}
if (!$eth0)
{
    write-host("")
    Write-Host("No connected ethernet interface found ! Please connect cable !")
    exit(1)
}
$Ipaddress_dc1=$eth0 | Get-NetIPAddress -AddressFamily IPv4

#
#Set correct DNS server primair own en second dc2
#

Set-DnsClientServerAddress -InterfaceIndex $eth0.ifIndex -ServerAddresses $Ipaddress_dc1,$Ipaddress_dc2