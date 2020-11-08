#set trusted hosts (Niet doen in productie)
#Set-Item WSMan:\localhost\Client\TrustedHosts -value *

#Test connection with remote server (Niet verplicht)
#Enter-PSSession -ComputerName 192.168.1.3 -Credential (Get-Credential)

#domain credentials
$cred = Get-Credential
Invoke-command `
-ComputerName 192.168.1.3 `
-Credential (Get-Credential) `
-scriptblock {Add-Computer -DomainName intranet.mijschool.be -credential $using:cred -Restart}