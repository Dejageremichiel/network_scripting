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
# Install Roles
#

$hostname=$env:COMPUTERNAME
$domain_name=$env:USERDNSDOMAIN
$domain_name=$domain_name.ToLower()

Install-WindowsFeature -Name DHCP -ComputerName $hostname -IncludeManagementTools

#Authorize DHCP server in domain

Add-DhcpServerInDc -IPAddress $Ipaddress_dc1.ipaddress -DnsName $domain_name

#
# configuring scope
#

Add-DhcpServerv4Scope `
-Computername $hostname `
-Name "First Scope" `
-StartRange 192.168.1.1 `
-EndRange 192.168.1.254 `-SubnetMask 255.255.255.0 `-LeaseDuration 8:0:0:0 `-State ActiveAdd-Dhcpserverv4ExclusionRange `-Computername $hostname `-ScopeID 192.168.1.0 `-StartRange 192.168.1.1 `-EndRange 192.168.1.10Set-DhcpServerv4OptionValue `-Computername $hostname `-ScopeID 192.168.1.0 `-Router 192.168.1.1Set-DhcpServerv4OptionValue `-ComputerName $hostname `-DnsServer 192.168.1.2, 192.168.1.3 `-Force `-DnsDomain $domain_nameAdd-DhcpServerv4Reservation `-ComputerName $hostname `-ScopeId 192.168.1.0 `-IPAddress 192.168.1.200 `-Name "printer1.$domain_name" `-ClientId "b8-e9-37-3e-55-86" `-Description "Printer"