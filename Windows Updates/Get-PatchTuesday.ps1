#========================================================================
# Created with: SAPIEN Technologies, Inc., PowerShell Studio 2012 v3.1.34
# Created on:   01/20/2018
# Created by:   Brandon Stevens
# Filename:     Get-PatchTuesday.ps1
#========================================================================
function Get-PatchTuesday{ 
<#  
  .SYNOPSIS   
    Get the Patch Tuesday of a month 
  .PARAMETER month 
   The month to check
  .PARAMETER year 
   The year to check
  .EXAMPLE  
   Get-PatchTue -month 6 -year 2015
  .EXAMPLE  
   Get-PatchTue June 2015
#> 
 
param( 
[string]$month = (get-date).month, 
[string]$year = (get-date).year
) 

$firstdayofmonth = [datetime] ([string]$month + "/1/" + [string]$year)
(0..30 | % {$firstdayofmonth.adddays($_) } | ? {$_.dayofweek -like "Tue*"})[1]
 
}