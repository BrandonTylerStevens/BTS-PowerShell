#========================================================================
# Created with: SAPIEN Technologies, Inc., PowerShell Studio 2012 v3.1.34
# Created on:   01/20/2018
# Created by:   Brandon Stevens
# Filename:     Get-Boottime.ps1
#========================================================================
$computername=$env:computername

$os=Get-WmiObject win32_operatingsystem -computername $computername

Write-Host ("Last boot: {0}" -f $os.ConvertToDateTime($os.lastbootuptime))
Write-Host ("Uptime   : {0}" -f ((get-date) - $os.ConvertToDateTime($os.lastbootuptime)).tostring())
