function Get-BrevoDomain {
    <#
    .SYNOPSIS
    Get the list of all your domains

    .DESCRIPTION
    The Get-BrevoDomain function sends a GET request to the Brevo API to retrieve information about the configured sender domains. 
    It uses the Invoke-BrevoCall function to perform the API call.

    .PARAMETERS
    This function does not take any parameters.

    .OUTPUTS
    Returns the response from the Brevo API containing the list of sender domains.

    .EXAMPLE
    PS> Get-BrevoDomain
    Retrieves the list of sender domains from the Brevo API.

    #>    
    [CmdletBinding()]
    param ()
    
    $params = @{
        "URI"    = "/senders/domains"
        "Method" = "GET"
    } 

    $Domain = Invoke-BrevoCall @params
    return $Domain
}