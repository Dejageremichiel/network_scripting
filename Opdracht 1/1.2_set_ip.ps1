$Ipaddress = "192.168.1.2"
$DNS_1 = "172.20.0.2"
$DNS_2 = "172.20.0.3"
$Defaultgateway = "192.168.1.1"
$Prefixlength = "24"

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

#
# Disable ipv6
#
Get-NetAdapterBinding -ComponentID 'ms_tcpip6' | Disable-NetAdapterBinding -ComponentID 'ms_tcpip6' -PassThru

#
# Set ipv4 static
#
New-NetIPAddress -InterfaceIndex $eth0.ifIndex -IPAddress $Ipaddress -PrefixLength $Prefixlength -DefaultGateway $Defaultgateway

#
#Static dns
#
Set-DnsClientServerAddress -InterfaceIndex $eth0.ifIndex -ServerAddresses $DNS_1,$DNS_2