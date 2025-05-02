<#
.SYNOPSIS
    Connects to the Brevo API using the provided API key and URI.

.DESCRIPTION
    The `Connect-Brevo` function authenticates to the Brevo API using the provided API key and optional API URI. 
    It sets the API URI and API key as script-scoped variables and attempts to connect to the Brevo API.

.EXAMPLE
    Connect-Brevo -APIkey (Get-Credential)

    Connects to the Brevo API using the provided API key and the default API URI.

.INPUTS
    The function does not accept pipeline input.

.OUTPUTS
    Returns $null if the connection fails, or the account information if the connection is successful.
    If the -NoWelcome switch is used, it returns $true if the connection is successful, otherwise $null.
#>
function Connect-Brevo {
    [CmdletBinding()]
    [OutputType([object])]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "The API key to use for authentication.")]
        [pscredential]$APIkey,
        [Parameter(Mandatory = $false, HelpMessage = "The complete URI of the Brevo API. e.g. https://api.brevo.com/v3/")]
        [Alias("uri", "apiurl")]
        [string]$APIuri = "https://api.brevo.com/v3",
        [Parameter(Mandatory = $false, HelpMessage = "Suppresses the welcome message.")]
        [switch]$NoWelcome
    )
    
    $script:APIuri = $APIuri
    $script:APIkey = $APIkey

    Write-Debug "$($MyInvocation.MyCommand):API URI: $script:APIuri"
    
    $params = @{
        "URI"    = "$script:APIuri/account"
        "Method" = "GET"
    } 

    $Account = Invoke-BrevoCall @params
    if ($Account) {
        Write-Host -ForegroundColor Green "Connected to Brevo API"
        if ($NoWelcome) {
            return $true
        }
        else {
            return $Account
        }
    }
    else {
        Write-Host -ForegroundColor Red "Failed to connect to Brevo API"
        return $null
    }
}