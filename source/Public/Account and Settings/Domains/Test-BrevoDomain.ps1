function Test-BrevoDomain {
    <#
    .SYNOPSIS
    Authenticate a domain

    .DESCRIPTION
    The `Test-BrevoDomain` function sends a GET request to check the existence or retrieve details of a specified mail domain using the Brevo API. The domain name is passed as a parameter, and the function returns the domain information.

    .PARAMETER name
    Specifies the mail domain name to be tested or queried. This parameter is mandatory.

    .EXAMPLE
    Test-BrevoDomain -name "example.com"

    This command authenticates the domain "example.com".

    .RETURNS
    Returns $true if the domain authenticates successfully
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "Mail domain name")]
        [string] $name
    )
    
    $params = @{
        "URI"    = "/senders/domains/$([uri]::EscapeDataString($name))"
        "Method" = "GET"
    } 

    $Domain = Invoke-BrevoCall @params
    return $Domain
}