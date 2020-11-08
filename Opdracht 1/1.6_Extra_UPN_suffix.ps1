#
# create extra upn suffix
#

$new_suffix="mijnschool.be"

Get-ADForest | Set-ADForest -UPNSuffixes @{add=$new_suffix}