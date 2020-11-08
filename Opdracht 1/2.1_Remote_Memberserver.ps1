#Enter-PSSession -ComputerName 192.168.1.4 -Credential (Get-Credential)

#domain credentials
$cred = Get-Credential
Invoke-command `
-ComputerName 192.168.1.4 `
-Credential (Get-Credential) `
-scriptblock {Add-Computer -DomainName intranet.mijschool.be -credential $using:cred -Restart}