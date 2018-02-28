function Push-Software{
    param
    (
        [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
        [String[]]$ComputerName,
        [switch]$restartServices, #Restart HPCA services in case computer is not responding
        [switch]$kill, #kill HPCA radpinit  in case computer is not responding
	    [switch]$phx, #Flag to force connection to 
        [switch]$l #Open the log
    )

    Foreach($cn in $ComputerName)
    {
        write-debug $cn
        if($restartServices){
		    Get-Service -DisplayName hpca* -ComputerName $cn |Restart-Service
	    }
	    if($kill){
            start-process taskkill.exe -ArgumentList "/s $cn  /fi `"imagename eq radconct*`" /f" -wait -NoNewWindow
		    start-process taskkill.exe -ArgumentList "/s $cn  /fi `"imagename eq nvdkit*`" /f" -wait -NoNewWindow
        }

	    if($phx){
		    start-process 'C:\Program Files (x86)\Hewlett-Packard\HPCA\Agent\radntfyc.exe' -ArgumentList "$cn radskman ip=SERVERHOSTNAME,port=3464,cat=prompt,ulogon=n,hreboot=n,dname=Software,log=connect_Software.log,rtimeout=60"
		    }
	    else{
            start-process 'C:\Program Files (x86)\Hewlett-Packard\HPCA\Agent\radntfyc.exe' -ArgumentList "$cn radskman cat=prompt,ulogon=n,hreboot=n,dname=Software,log=connect_Software.log,rtimeout=60"		    
            }
        if($l){
            Invoke-Item "\\$cn\c$\Program Files (x86)\Hewlett-Packard\HPCA\Agent\Log\connect_Software.log"
        }
    }
}
