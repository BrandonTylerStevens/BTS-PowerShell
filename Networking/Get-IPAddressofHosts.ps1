#========================================================================
# Created with: SAPIEN Technologies, Inc., PowerShell Studio 2012 v3.1.34
# Created on:   01/20/2018
# Created by:   Brandon Stevens
# Filename:     Get-IPAddressofHosts.ps1
#========================================================================
function Get-HostToIP($hostname) {    
    $result = [system.Net.Dns]::GetHostByName($hostname)    
    $result.AddressList | ForEach-Object {$_.IPAddressToString }
}

Get-Content "C:\Temp\Servers.txt" | ForEach-Object {(Get-HostToIP($_)) + ($_).HostName >> C:\Temp\Addresses.txt}