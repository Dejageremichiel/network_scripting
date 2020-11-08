$Domain_name = "intranet.mijschool.be"
$NetbiosName = "mijnschool"

#
#Install Active Directory
#
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools

#
#create Domain controller
#

Install-ADDSForest `
-DomainName $Domain_name `
-CreateDnsDelegation:$false `
-DatabasePath "C:\Windows\NTDS" `
-DomainMode "7" `
-DomainNetbiosName $NetbiosName `
-ForestMode "7" `
-InstallDns:$true `
-LogPath "C:\Windows\NTDS" `
-NoRebootOnCompletion:$false `
-SysvolPath "C:\Windows\SYSVOL" `
-Force:$true