#Connect to member server
Enter-PSSession -ComputerName 192.168.1.4 -Credential (Get-Credential)

#make a folder on the member server called home

New-Item 'c:\Public' -ItemType Directory

#Now make it a shared folder with share permissions to full control

New-SMBShare –Name PublicShare –Path C:\Public | Grant-SmbShareAccess -AccountName Everyone -AccessRight Full

#disable inheritance

$folder = 'C:\Public'
$acl = Get-ACL -Path $folder
$acl.SetAccessRuleProtection($True, $True)
Set-Acl -Path $folder -AclObject $acl

#verwijderen rechten user

$acl = Get-Acl "C:\Public"
$accessrule = New-Object System.Security.AccessControl.FileSystemAccessRule("system", "Read",,,"Allow")
$acl.RemoveAccessRuleAll($accessrule)
Set-Acl -Path "C:\Public" -aclObject $acl

#set ntfs permissions: Administrator full control, authenticated user - modify on the folder onley (advanced permissions

$folder='C:\Public'
$acl = Get-ACl $folder
$accessrule = New-Object System.Security.AccessControl.FileSystemAccessRule("Authenticated users", "FullControl", "allow")
$acl.SetAccessRule($accessrule)
$acl | Set-Acl $folder