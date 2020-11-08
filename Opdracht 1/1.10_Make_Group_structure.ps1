$csv = Import-Csv C:\Users\Administrator\Desktop\Scripting\Intranet\Groups.csv -Delimiter ";"

foreach ($item in $csv)
{
    #Write-Host $item.Path
    New-ADGroup `
    -Name $item.Name `
    -DisplayName $item.'Display Name' `
    -Path $item.Path `
    -Description $item.Descriptionµ `
    -GroupCategory $item.GroupCategory `
    -GroupScope $item.GroupScope

    Write-Host -ForegroundColor Green "OU $($item.Name) created!"
}