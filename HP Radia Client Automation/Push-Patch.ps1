#----------------------------
#Forces a patch connect of machine passed in parameters
#
#Input: 
#    $ComputerName = hostname of target computer
#    $phx = flag to connect to phx fss server. If not specified the machine will connect to local fss server
#
#Usage: .\ pushPatch.ps1 <hostnames> ex: pushPatch.ps1 ComputerHostname or pushPatch.ps1 ComputerHostname1,ComputerHostname2,ComputerHostname3
#Also recommended usage: Get-Content hostnames.txt | ForEach-Object { pushPatch.ps1 $_}
#
#----------------------------
function Push-Patch {
    param
    (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [String[]]$ComputerName,
        [switch]$phx, #Flag to force connection to SERVERHOSTNAME,
        #[switch]$phx2, #Flag for new server. Replaced with just normal
        [switch]$restartServices, #Restart HPCA services in case computer is not responding
        [switch]$kill, #kill HPCA radpinit  in case computer is not responding
        [switch]$enableWindowsUpdate,
        [switch]$EWU
    )

    
    Foreach ($cn in $ComputerName) {
        write-debug $cn
        if ($restartServices) {
            Get-Service -DisplayName hpca* -ComputerName $cn |Restart-Service
        }
        if ($kill) {
            start-process taskkill.exe -ArgumentList "/s $cn  /fi `"imagename eq radconct*`" /f" -wait -NoNewWindow
            start-process taskkill.exe -ArgumentList "/s $cn  /fi `"imagename eq nvdkit*`" /f" -wait -NoNewWindow
            start-process taskkill.exe -ArgumentList "/s $cn  /fi `"imagename eq rad*`" /f" -wait -NoNewWindow
        }

        if ($enableWindowsUpdate -or $EWU) {
            Get-Service -DisplayName "Windows Update" -ComputerName $cn |start-Service
        }

        #Old server
       	
        #if($phx){
        #  Start-Process 'C:\Program Files (x86)\Hewlett-Packard\HPCA\Agent\radntfyc.exe' -ArgumentList "$cn radskman ip=SERVERHOSTNAME,port=3464,cat=prompt,uid=$cn,ulogon=n,hreboot=n,dname=Patch,log=connect_Patch.log,rtimeout=60,rcsuri=tcp://SERVERHOSTNAME:3464,datauri=http://SERVERHOSTNAME:3466"
        #}
        #else
        
        if ($phx) {
            Start-Process 'C:\Program Files (x86)\Hewlett-Packard\HPCA\Agent\radntfyc.exe' -ArgumentList "$cn radskman ip=SERVERHOSTNAME,port=3464,cat=prompt,ulogon=n,hreboot=n,dname=Patch,log=connect_Patch.log,rtimeout=60,rcsuri=tcp://SERVERHOSTNAME:3464,datauri=http://SERVERHOSTNAME:3466"
        }
        else {
            start-process 'C:\Program Files (x86)\Hewlett-Packard\HPCA\Agent\radntfyc.exe' -ArgumentList "$cn radskman cat=prompt,ulogon=n,hreboot=n,dname=Patch,log=connect_Patch.log,rtimeout=60"
        }
        
    }
}

function Push-Patch-Parallel {
    param
    (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [String]$InputObject,
        [switch]$kill
    )
    
    Invoke-Parallel -InputObject (get-content($InputObject)) -ScriptBlock {
        . "E:\WindowsPowerShell\Modules\Push-Patch.ps1";
        if ($kill) {
            push-patch $_ -kill
        }
        else {
            push-patch $_
        }
    } -Throttle 30 -runspacetimeout 40 
}
