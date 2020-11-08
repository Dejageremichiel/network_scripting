#
# Renaming default first site name
#

$new_site_name="Kortrijk"
$Subnet="192.168.1.0/24"

Get-ADReplicationSite "Default-First-Site-Name" | Rename-ADObject -NewName $new_site_name
Get-ADReplicationSite $new_site_name | Set-ADReplicationSite -Description $new_site_name
New-ADReplicationSubnet -Name $Subnet $new_site_name -Description $new_site_name

