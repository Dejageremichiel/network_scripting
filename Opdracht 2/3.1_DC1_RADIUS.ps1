
do { $autoShareSecret = read-host -Prompt 'Do you want to give everyone the same SharedSecret?(Y/N)'.ToLower()} while ($autoShareSecret -notin @('y','n'))

# hier wordt de sharedsecret gevraagd aan de user
if ($autoShareSecret -eq 'y'){

    $FileCSV = "C:\users\Administrator\Desktop\scripting2\radiusclients.csv"
    $radiusclients=Import-CSV $FileCSV -Delimiter ";"
    $SharedSecret = read-Host -Prompt 'Give sharedsecret:'
    ForEach($client in $radiusclients) {
    try {  

            New-NpsRadiusClient -Address $client.Address`
            -Name $client.Name `
            -SharedSecret $SharedSecret

            "$($client.name) 's made" | Out-File "c:\logradiusclient.txt" -Append
    }

    catch{
        $error[0].Exception |out-file "c:\logradiusclient.txt" -Append
    }
    }

}
else{
    write-host 'hier geraakt'
    $FileCSV = "C:\users\Administrator\Desktop\scripting2\radiusclientWithShareSecret.csv"
    $radiusclients=Import-CSV $FileCSV -Delimiter ";"
    ForEach($client in $radiusclients) {
    try {  
            New-NpsRadiusClient -Address $client.Address`
            -Name $client.Name `
            -SharedSecret $client.SharedSecret

            "$($client.name) 's made" | Out-File "c:\logradiusclient.txt" -Append
    }

    catch{
        $error[0].Exception |out-file "c:\logradiusclient.txt" -Append
    }
    }
}