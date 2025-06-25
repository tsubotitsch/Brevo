function New-BrevoDomain {
    <#
    .SYNOPSIS
    Creates a new mail domain.

    .DESCRIPTION
    The New-BrevoDomain function is used to create a new mail domain by sending a POST request to the "/senders/domains" endpoint. 
    It requires the domain name as input and returns the created domain information.

    .PARAMETER name
    Specifies the name of the mail domain to be created. This parameter is mandatory.

    .EXAMPLE
    PS> New-BrevoDomain -name "example.com"
    Creates a new mail domain with the name "example.com".
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "Mail domain name")]
        [string] $name
    )
    
    $params = @{
        "URI"    = "/senders/domains"
        "Method" = "POST"
    } 

    $body = @{
        name = $name
    }

    $Domain = Invoke-BrevoCall @params
    return $Domain
}