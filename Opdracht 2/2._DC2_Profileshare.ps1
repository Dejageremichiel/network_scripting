

Invoke-Command -ComputerName Win04-DC2 -ScriptBlock { 

#get file shares
Get-SMBShare

#nieuwe file share
New-Item "C:\Profiles" -type directory

New-SMBShare -Name "Profiles" -Path "C:\Profiles" -FullAccess Everyone
$f = get-item "C:\Profiles" -Force
$f.Attributes="Hidden"


} -Credential mijnschool\Administrator 


#alle users read and write rechten geven

Invoke-Command -ComputerName Win04-DC2 -ScriptBlock {

$acl = Get-Acl "C:\Profiles"
#verwijderen rechten
$accessrule = New-Object System.Security.AccessControl.FileSystemAccessRule("Users", "Read",,,"Allow")
$acl.RemoveAccessRuleAll($accessrule)
Set-Acl -Path "C:\Profiles" -aclObject $acl

#toevoegen van rechten
$Accesrule = New-Object System.Security.AccessControl.FileSystemAccessRule("authenticated users", "FullControl","Allow")

$acl.SetAccessRule($Accesrule)
$acl | Set-Acl "C:\Profiles"
# uitschakelen inheritance
$acl.SetAccessRuleProtection($True, $True)
$acl | Set-Acl "C:\Profiles"


} -Credential mijnschool\Administrator 


#in de profile path van de user steken.

Import-Module ActiveDirectory


$properties = "ProfilePath", "ScriptPath", "l"
$ou = "OU=Secretariaat, OU=Mijn school,DC=intranet,DC=mijnschool,DC=be" 

Get-ADUser -Filter * -SearchBase $ou -Properties $properties | 
ForEach-Object{
   $Profilepath = "\\Win04-DC2\Profiles\{0}" -f $_.SamAccountName
   Set-Aduser $_.SamAccountName -ProfilePath $Profilepath

}