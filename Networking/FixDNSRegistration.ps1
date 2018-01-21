#========================================================================
# Created with: SAPIEN Technologies, Inc., PowerShell Studio 2012 v3.1.34
# Created on:   01/20/2018
# Created by:   Brandon Stevens
# Filename:     FixDNSRegistration.ps1
# Requirements: Module DnsClient
#========================================================================
$servers = get-content .\computers.txt
Get-DnsClient -CimSession $servers |
    Select-object  PsComputerName,Interface*,Register* |
    Where-Object {$_.InterfaceAlias -like "backup*"} |
     Out-GridView -PassThru | 
     ForEach-Object {
        Set-DnsClient -InterfaceAlias $_.InterfaceAlias -CimSession $_.PScomputerName -RegisterThisConnectionsAddress $false -Verbose
        }