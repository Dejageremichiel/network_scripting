$csv = Import-Csv C:\Users\Administrator\Desktop\Scripting\Intranet\UserAccounts.csv -Delimiter ";"

foreach ($item in $csv)
{
    $AccountPassword = ConvertTo-SecureString $item.AccountPassword -AsPlainText -force
    #Write-Host $item.Path
    New-ADUser `
    -Name $item.Name `
    -SamAccountName $item.SamAccountName `
    -GivenName $item.GivenName `
    -Surname $item.Surname `
    -DisplayName $item.DisplayName `
    -AccountPassword $AccountPassword `
    -HomeDrive $item.HomeDrive `
    -HomeDirectory $item.HomeDirectory `
    -ScriptPath $item.ScriptPath `
    -Path $item.Path

    Write-Host -ForegroundColor Green "User $($item.Name) created!"
}

#enabling all users 
$csv = Import-Csv C:\Users\Administrator\Desktop\Scripting\Intranet\UserAccounts.csv -Delimiter ";"

foreach ($item in $csv)
{
    Enable-ADAccount -Identity $item.Name
    IF ($Error.Count -ne 0)
    {
    $ThisSTR = $item.Name +", Was enabled successfully."
    }
    else
    {
    $ThisSTR = $item.Name +", Error enabling User account"
    }
}