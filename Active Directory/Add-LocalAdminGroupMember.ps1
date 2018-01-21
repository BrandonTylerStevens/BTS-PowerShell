#========================================================================
# Created with: SAPIEN Technologies, Inc., PowerShell Studio 2012 v3.1.34
# Created on:   01/20/2018
# Created by:   Brandon Stevens
# Filename:     Add-LocalAdminGroupMember.ps1
#========================================================================

$Servers = "ServerHostname", "ServerHostname", "ServerHostname"
$Users = "Active Directory Group"

foreach ($Server in $Servers) {
	$Group = [ADSI]("WinNT://$Server/Administrators,group")
	foreach ($User in $Users) {
		try {
			$Group.Add("WinNT://chw.edu/$User")
		}
		catch {
			Write-Output $Server,$User,$($_.Exception.Message.Replace("`n",""))
		}
	}
}