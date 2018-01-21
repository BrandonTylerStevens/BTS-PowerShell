#========================================================================
#Delete patch and data folders in HPCA and force a patch connect
#$ComputerName = hostname of target computer
#Usage: Delete-PatchData.ps1 <hostnames> ex: Delete-PatchData Hostname or Delete-PatchData Hostname1,Hostname2,Hostname3
#Also recommended example: Get-Content hostnames.txt | ForEach-Object { Delete-PatchData.ps1 $_}
#========================================================================
function Delete-PatchData{
    param
    (
        [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
        [String[]]$ComputerName
        
    )

    Foreach($cn in $ComputerName)
    {
	    try{
    
   
        if(Test-Path "\\$cn\c$\Program Files (x86)\Hewlett-Packard\HPCA\Agent\Lib\SYSTEM\RADIA\PATCH\ZSERVICE\DISCOVER_PATCH"){

            Remove-Item "\\$cn\c$\Program Files (x86)\Hewlett-Packard\HPCA\Agent\Lib\SYSTEM\RADIA\PATCH\ZSERVICE\DISCOVER_PATCH" -Recurse -Force
            Remove-Item "\\$cn\c$\Program Files (x86)\Hewlett-Packard\HPCA\Agent\Lib\SYSTEM\RADIA\PATCH\ZSERVICE\FINALIZE_PATCH" -Recurse -Force
            }
        elseif(Test-Path "\\$cn\c$\Program Files\Hewlett-Packard\HPCA\Agent\Lib\SYSTEM\RADIA\PATCH\ZSERVICE\DISCOVER_PATCH"){
				
			Remove-Item "\\$cn\c$\Program Files\Hewlett-Packard\HPCA\Agent\Lib\SYSTEM\RADIA\PATCH\ZSERVICE\DISCOVER_PATCH" -Recurse -Force
			Remove-Item "\\$cn\c$\Program Files\Hewlett-Packard\HPCA\Agent\Lib\SYSTEM\RADIA\PATCH\ZSERVICE\FINALIZE_PATCH" -Recurse -Force
            }

        New-Object psobject -Property @{
                    ComputerName = $cn
                    ErrorCode= Removed
                    }
    }catch{
        New-Object psobject -Property @{
                    ComputerName = $cn
                    ErrorCode= "Could not open log"
                    }
        }
    }
}