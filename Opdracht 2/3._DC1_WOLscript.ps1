
#op welke machine staat dhcp server
$DHCP_Server = 'Kortrijk-DC1.intranet.mijschool.be' 
 
#Aantal keer paketten zal verzend worden
$Attempts = '5' 
 
#Tijd tussen de keren hij probeert
$Sleep = '2' 
 
#Lan poort numer 
$WOL_Port = '9' 

#toon alle hosts die dhcp gebruiken
 Get-DhcpServerv4Scope -computername $DHCP_Server | Get-DhcpServerv4Lease -computername $DHCP_Server 

#vraagt om welke host je wilt 
$Host_Name = Read-Host -prompt "Host Name" 
 
#resolving dns name
 
$DNS_Resolution = resolve-dnsname -name $Host_Name 
 
#DHCP server
 
$DHCP_Leases = Get-DhcpServerv4Scope -computername $DHCP_Server | Get-DhcpServerv4Lease -computername $DHCP_Server 
 
#Client info van dhcp server
 
$Host_Info = $DHCP_Leases | Where-Object IPAddress -eq $DNS_Resolution.IPAddress 
$Host_Info
 
#IP Adress in variabele
 
$IPAddress = $Host_Info.IPAddress 
 
#Mac address in variabele
 
$MAC_Address = $Host_Info.ClientId 
 
#WOL functie Online

function Send-WOL 
{ 
 
[CmdletBinding()] 
param( 
[Parameter(Mandatory=$True,Position=1)] 
[string]$mac, 
[string]$ip="255.255.255.255",  
[int]$port=9 
) 
$broadcast = [Net.IPAddress]::Parse($ip) 
  
$mac=(($mac.replace(":","")).replace("-","")).replace(".","") 
$target=0,2,4,6,8,10 | % {[convert]::ToByte($mac.substring($_,2),16)} 
$packet = (,[byte]255 * 6) + ($target * 16) 
  
$UDPclient = new-Object System.Net.Sockets.UdpClient 
$UDPclient.Connect($broadcast,$port) 
[void]$UDPclient.Send($packet, 102)  
 
} 
$Ping_Test = Test-Connection -ComputerName $IPAddress -Quiet 
$Attempt = 1 
 
while ($Ping_Test -eq $false -and $Attempt -le $Attempts) { 
        Write-Host "Sending Magic Packet...Attempt - " $Attempt -ForegroundColor Yellow 
        Send-WOL -mac $MAC_Address -ip $IPAddress -port $WOL_Port 
        Start-Sleep $Sleep 
        $Ping_Test = Test-Connection -ComputerName $IPAddress -Quiet 
        $Attempt++ 
}        
if ($Ping_Test -eq $true){  
    Write-Host "" 
    Write-Host "###############" -ForegroundColor Green 
    Write-Host "Host is Online!" -ForegroundColor Green 
    Write-Host "###############" -ForegroundColor Green 
} 
 
else { 
    Write-Host "" 
    Write-Host "########################################" -ForegroundColor Red 
    Write-Host "Host is still offline. Please try again." -ForegroundColor Red 
    Write-Host "########################################" -ForegroundColor Red 
} 
 
 
 