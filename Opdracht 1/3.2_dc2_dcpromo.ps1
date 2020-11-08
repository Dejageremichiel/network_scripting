$DC2_IP = 192.168.1.3

#Commands runnen op remote dc2 server
Invoke-command `
-ComputerName $using:DC2_IP `
-Credential (Get-Credential) `
-scriptblock {Install-WindowsFeature AD-Domain-Services -IncludeManagementTools}



$Domain_name = "intranet.mijschool.be"

Invoke-command `
-ComputerName $using:DC2_IP `
-scriptblock {Install-ADDSDomainController  -DomainName $using:Domain_name -credential $(get-credential)}
