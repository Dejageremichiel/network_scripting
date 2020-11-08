Enter-PSSession -ComputerName 192.168.1.3 -Credential (Get-Credential)

Install-WindowsFeature -Name DHCP -IncludeManagementTools


#Install on DC1
Add-DhcpServerv4Failover -ComputerName 192.168.1.2 -PartnerServer 192.168.1.3 -Name "DHCP-01_DHCP-02_Hot_standby" -ServerRole Active -ReservePercent 10 -MaxClientLeadTime 1:00:00 -StateSwitchInterval 00:45:00 -ScopeId 192.168.1.0 -SharedSecret "Pa$$w0rd"

#Authorize DHCP server on DC 1 and 2
Add-DhcpServerInDC -DnsName "win04-DC2.intranet.mijschool.be" -IPAddress 192.168.1.3

#Post-deployement configuration DHCP
Set-ItemProperty –Path registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ServerManager\Roles\12 –Name ConfigurationState –Value 2
