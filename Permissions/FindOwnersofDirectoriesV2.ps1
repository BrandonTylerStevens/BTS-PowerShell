﻿#========================================================================
# Created with: SAPIEN Technologies, Inc., PowerShell Studio 2012 v3.1.34
# Created on:   01/20/2018
# Created by:   Brandon Stevens
# Filename:     FindOwnersofDirectoriesV2.ps1
#========================================================================

$logfile = "\\ServerHostname\Directory\Folder"

$RootPath = "\\ServerHostname\Directory\Folder\"

if (Test-Path $logfile) {
	Clear-Content $logfile
}


cls
Write-Host "Getting Directories at $path"
$Directories= Get-ChildItem -Path $RootPath -Recurse | ? {($_.gettype().name) -eq "DirectoryInfo"}

# this line creates a header for the logfile
Add-Content -Path $logfile -Value "Object Type`tFull Path`tLastAccessTime`tLastWriteTime`tOwner in ACL"
$count = 0
$Directories | foreach-object {
		$count++
		$type = $_.gettype().name.trimend("Info")
		$fullname = $_.fullname
		$LastAccessTime = $_.LastAccessTime
		$LastWriteTime = $_.LastWriteTime
		$acl = Get-Acl  $fullname
		$owner = $acl.owner
	
	
#		Write-Host "$type`t$fullname`t$owner"
		
		Add-Content -Path $logfile -Value "$type`t$fullname`t$LastAccessTime`t$LastWriteTime`t$owner"
	
		$PercentComplete = $count/$Directories.count/.01
	
		Write-Progress -Activity "Getting Directory Stats for $RootPath"  -PercentComplete $PercentComplete -Status "Working on Directory $fullname"
	
}

Write-Host "Finished getting directory owners at $RootPath" -ForegroundColor Green
Write-Host "You can find the logfile at $Logfile"

