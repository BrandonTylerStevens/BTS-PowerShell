Function Connect-ExchangeOnline
{
    <#
    .SYNOPSIS
        Create a connection to Exchange online and import the cmdlets it provides.
    .DESCRIPTION
        Create a connection to Exchange online and import the cmdlets it provides.
    .PARAMETER Credential
        Specify alternate credentials.
    .EXAMPLE
        $session = Connect-ExchangeOnline

    .OUTPUTS
        [System.Management.Automation.Runspaces.PSSession]
    #>
    [Cmdletbinding()]
    Param ()

    try {
        $sessionParams = @{
            ConfigurationName = 'Microsoft.Exchange'
            ConnectionUri     = 'https://outlook.office365.com/powershell-liveid/'
            Authentication    = 'Basic'
            AllowRedirection  = $true
            ErrorAction       = 'Stop'
        }

        # Create a session object.
        Write-Verbose -Message 'Creating a new session to Exchange Online....'
        $session = New-PSSession -Credential (Get-Credential) @sessionParams

        # import the session object
        Write-Verbose -Message 'Importing the session...'
        Import-PSSession -DisableNameChecking $session

        # Return the session object
        $session
    } catch {
        Write-Error -Message "$_.Exception.Message"
    }
} # Connect-ExchangeOnline


Function Disconnect-ExchangeOnline
{
    <#
    .SYNOPSIS
        Disconnects Exchange Online session.
    .DESCRIPTION
        Locates and disconnects any found Exchange Online sessions.
    .EXAMPLE
        Disconnect-ExchangeOnline
        Disconects any remote sessions to Exchange Online.
    #>
    [CmdletBinding()]
    Param ()

    # Find and save any PSSessions on the system
    $session = (Get-PSSession).where({$_.ComputerName -eq 'outlook.office365.com' -and $_.ConfigurationName -eq 'Microsoft.Exchange'})

    if ($session.count -ge 1) {
        write-warning -message "$($session.count) Exchange Online sessions were found.  They will be disconnected."
        foreach ($s in $session) {
            write-warning -message "Disconnecting session id #$($s.id)"
            $s | Remove-PSSession
        }
    } else {
        write-warning -message 'A PowerShell session to Exchange Online was not found.'
    }
} # Disconnect-ExchangeOnlinea