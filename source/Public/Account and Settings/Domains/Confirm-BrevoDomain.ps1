function Confirm-BrevoDomain {
    <#
    .SYNOPSIS
    Confirms the authentication status of a specified mail domain.
    
    .DESCRIPTION
    The Confirm-BrevoDomain function sends a GET request to check the authentication status of a specified mail domain using the Brevo API. It constructs the API endpoint dynamically based on the provided domain name.
    
    .PARAMETER name
    The name of the mail domain to confirm. This parameter is mandatory.
    
    .EXAMPLE
    PS> Confirm-BrevoDomain -name "example.com"
    Returns the authentication status of the domain "example.com".
    
    .RETURNS
    Object
    The response object containing the domain authentication details.
    #>
    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "Mail domain name")]
        [string] $name
    )
    
    $params = @{
        "URI"    = "/senders/domains/$([uri]::EscapeDataString($name))/authenticate"
        "Method" = "GET"
    } 

    $Domain = Invoke-BrevoCall @params
    return $Domain
}