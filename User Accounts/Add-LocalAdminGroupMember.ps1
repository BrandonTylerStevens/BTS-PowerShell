#========================================================================
# Created with: SAPIEN Technologies, Inc., PowerShell Studio 2012 v3.1.32
# Created on:   5/2/2014 1:14 PM
# Created by:   Brandon Stevens
# Organization: Banner Health
# Filename:     Add-LocalAdminGroupMember.ps1
#========================================================================

$Servers = "server hostname1", "server hostname 2", "server hostname 3"
$Users = "AZlgSoftmedAdminGroup"

foreach ($Server in $Servers) {
	$Group = [ADSI]("WinNT://$Server/Administrators,group")
	foreach ($User in $Users) {
		try {
			$Group.Add("WinNT://BHS/$User")
		}
		catch {
			Write-Output $Server,$User,$($_.Exception.Message.Replace("`n",""))
		}
	}
}
