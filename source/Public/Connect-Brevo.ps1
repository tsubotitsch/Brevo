
function Connect-Brevo {
    <#
    .SYNOPSIS
    Connects to the Brevo API using the provided API key and URI.

    .DESCRIPTION
    The Connect-Brevo function authenticates to the Brevo API using the provided API key and optional API URI. 
    It sets the API URI and API key as script-scoped variables and attempts to connect to the Brevo API.

    .PARAMETER APIkey
    The API key to use for authentication. This parameter is mandatory.

    .PARAMETER APIuri
    The complete URI of the Brevo API. This parameter is optional and defaults to "https://api.brevo.com/v3".

    .EXAMPLE
    PS> $apiKey = Get-Credential
    PS> Connect-Brevo -APIkey $apiKey

    .Connects to the Brevo API using the provided API key and the default API URI.

    .EXAMPLE
    PS> $apiKey = Get-Credential
    PS> Connect-Brevo -APIkey $apiKey -APIuri "https://custom.api.brevo.com/v3"

    .Connects to the Brevo API using the provided API key and a custom API URI.

    .OUTPUTS
    Returns the account information from the Brevo API if the connection is successful.

    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "The API key to use for authentication.")]
        [pscredential]$APIkey,
        [Parameter(Mandatory = $false, HelpMessage = "The complete URI of the Brevo API. e.g. https://api.brevo.com/v3/")]
        [Alias("uri", "apiurl")]
        [string]$APIuri = "https://api.brevo.com/v3"
    )
    
    $script:APIuri = $apiuri
    $script:APIkey = $APIkey

    Write-Debug "$($MyInvocation.MyCommand):API URI: $script:APIuri"
    #Write-Debug "API Key: $($script:APIkey.GetNetworkCredential().Password)"
    
    $params = @{
        "URI"       = "$script:APIuri/account"
        "Method"    = "GET"
        ErrorAction = "Stop"
    } 

    try {
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
    catch {
        Write-Error "An error occurred while connecting to the Brevo API: $_" -Category ConnectionError -RecommendedAction "Check your API key, URI and IP Whitelist. NOTE: The external IP of the machine running this script must be whitelisted in your Brevo account."
        return $null
    }
}