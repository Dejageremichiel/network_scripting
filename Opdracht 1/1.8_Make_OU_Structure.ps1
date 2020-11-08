$csv = Import-Csv C:\Users\Administrator\Desktop\Scripting\Intranet\OUs.csv -Delimiter ";"

foreach ($item in $csv)
{
    #Write-Host $item.Path
    New-ADOrganizationalUnit `
    -Name $item.Name `
    -DisplayName $item.'Display Name' `
    -Path $item.Path `
    -Description $item.Description

    Write-Host -ForegroundColor Green "OU $($item.Name) created!"
}
