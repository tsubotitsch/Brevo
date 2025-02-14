function Connect-Brevo {
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
        "URI"    = "$script:APIuri/account"
        "Method" = "GET"
    } 

    $Account = Invoke-BrevoCall @params
    if ($Account) {
        Write-Host -ForegroundColor Green "Connected to Brevo API"
    }
    else {
        Write-Host -ForegroundColor Red "Failed to connect to Brevo API"
    }
}