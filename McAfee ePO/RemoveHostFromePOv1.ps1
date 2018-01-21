#========================================================================
# Created with: SAPIEN Technologies, Inc., PowerShell Studio 2017
# Created on:   01/21/2018
# Created by:   Brandon Stevens
# Organization: Banner Health
# Filename:     RemoveHostFromePO.ps1
#========================================================================
[System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true} # Causes WebClient to ignore certification validation
$Credential = Get-Credential -Credential "$env:USERDOMAIN\$env:USERNAME"
$WebClient = New-Object System.Net.WebClient
$WebClient.Credentials = $Credential.GetNetworkCredential()
$ePOServer = "https://epo.CHW.EpoURL.com:8443"
$Computer = Read-Host -Prompt "Enter PC name or username"
$SearchURL = "$epoServer/remote/system.delete?names=$Computer&:output=xml"
[XML]$ResultXML = $WebClient.DownloadString($SearchURL).Replace("OK:`r`n","")
$ResultXML.result.list.element.CmdReturnStatus | select-object name,message,@{Name="Username";expression={$env:USERNAME}} | export-csv "\\ServerHostname4\Removing Host from ePO\Hostname Removed from ePO.csv" –NoTypeInformation -Append
