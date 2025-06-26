function Get-BrevoSender {
    <#
    .SYNOPSIS
    Get the list of all your senders

    .DESCRIPTION
    The Get-BrevoSender function sends a GET request to the Brevo API to retrieve information about the configured sender domains. 
    It uses the Invoke-BrevoCall function to perform the API call.

    .PARAMETERS
    This function does not take any parameters.

    .OUTPUTS
    Returns the response from the Brevo API containing the list of sender domains.

    .EXAMPLE
    PS> Get-BrevoSender
    Retrieves the list of sender domains from the Brevo API.

    #>    
    [CmdletBinding()]
    param ()

    $params = @{
        "URI"    = "/senders"
        "Method" = "GET"
        "returnobject" = "senders"
    } 

    return Invoke-BrevoCall @params
}
