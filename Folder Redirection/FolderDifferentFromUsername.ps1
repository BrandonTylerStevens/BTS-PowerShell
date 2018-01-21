﻿#========================================================================
# Created with: SAPIEN Technologies, Inc., PowerShell Studio 2012 v3.1.32
# Created on:   01/20/2018 10:05 AM
# Created by:   Brandon Stevens
# Filename:     FolderDifferentFromUsername.ps1
#========================================================================
Import-Module DFSN
Import-Module ActiveDirectory
$Path = Read-Host -Prompt "Enter path to check [e.g. \\ServerHostname\users1]"
if (Test-Path $Path) {
	$Users = [System.IO.Directory]::GetDirectories($Path)
	$Users = $Users | ForEach-Object {$_.Split("\")[-1]}
}
else {
	throw {"The path entered could not be found."}
}
$Date = Get-Date -Format MMddyyyy_HHmmss
if ((Test-Path "C:\Temp") -eq $false){New-Item -Path "C:\Temp" -type directory}
$FilePath = "C:\Temp\" + "UsersNeedAttention" + "_" + $Date + ".csv"
$File = New-Object System.IO.StreamWriter($FilePath, $true)
$File.AutoFlush = $true
$File.WriteLine("FolderName" + "," + "SamAccountName" + "," + "HomeDirectory" + "," + "Target")
foreach ($User in $Users) {
	Write-Output $User
	$HomeDirectory = "*\" + $User
	try {
		$ByFolderName = Get-ADUser -Identity $User -ErrorAction 'Stop'
	}
	catch {
		$Target = $null
		$ByHomeDirectory = Get-ADUser -Filter {HomeDirectory -like $HomeDirectory} -Properties HomeDirectory -ErrorAction 'SilentlyContinue';trap{continue}
		if ($ByHomeDirectory -ne $null) {
			$Target = Get-DfsnFolderTarget $ByHomeDirectory.HomeDirectory | Select-Object -ExpandProperty TargetPath -ErrorAction 'SilentlyContinue';trap{continue}
		}
		else {
			$Target = Get-DfsnFolderTarget ("\\ServerHostname\hf\" + $User) | Select-Object -ExpandProperty TargetPath -ErrorAction 'SilentlyContinue';trap{continue}
		}
		$File.WriteLine($User + "," + $ByHomeDirectory.SamAccountName + "," + $ByHomeDirectory.HomeDirectory + "," + $Target)
	}
}
$File.Close()
Write-Output $FilePath
Pause