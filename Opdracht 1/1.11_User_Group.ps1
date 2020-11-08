$csv = Import-Csv C:\Users\Administrator\Desktop\Scripting\Intranet\GroupMembers.csv -Delimiter ";"

foreach ($item in $csv)
{
    #Write-Host $item.Path
    Add-ADGroupMember `
    -Members $item.Member `
    -Identity $item.Identity

    Write-Host -ForegroundColor Green "Person $($item.Member) added!"
}