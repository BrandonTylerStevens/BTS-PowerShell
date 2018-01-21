﻿#$wsusserver = Get-WsusServer -Name wsus -port 8530
#$wsus=$wsusserver
Function Convert-WSUSHTTPPathtoSMB
{
    param ([string[]]$fileuri="http://wsus:8530/Content/36/721D140CB51C2120C7F016CEC18B660FFD3E9B36.cab",
            [string]$wsusContentPath = "\\wsus\wsuscontent")
        foreach ($filepath in $fileuri)
        {
        "$wsusContentPath\" +($fileuri -split "content/")[1] -replace "/","\"
        }
   
}

#$updates = Get-WsusUpdate -Approval Approved -UpdateServer $wsus -ErrorAction stop 
#$updates = $updates | Select-Object -ExcludeProperty wsuscabpath
    $cabUpdates =  $updates | Foreach-object {
         $cab = $_.update.GetInstallableItems().files | Where-Object {$_.name -notlike "*express*" -and $_.name -like "*.cab"} 
         if ($cab.count -gt 1)
         {
            #Write-Error "more than one cab"
            Write-Verbose "more than one cab in $($_.update.title)"
            $cabPath = Convert-WSUSHTTPPathtoSMB -fileuri $cab.fileuri -wsusContentPath "\\wsus\wsuscontent"
            $_ |  Add-Member -MemberType NoteProperty -Name WSUSCabPath -Value $cabPath -PassThru
            Write-Verbose $cab

         }
         elseif(-not $cab)
         {
            write-verbose "no cab in $($_.update.title)"
         }
         Else
         {
            If ($cab)
           {$cabPath = Convert-WSUSHTTPPathtoSMB -fileuri $cab.fileuri -wsusContentPath "\\wsus\wsuscontent"
         $_ |  Add-Member -MemberType NoteProperty -Name WSUSCabPath -Value $cabPath -PassThru}
         }
        }
