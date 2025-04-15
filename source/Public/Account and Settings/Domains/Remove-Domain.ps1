function Remove-Domain {
    <#
    .SYNOPSIS
    Removes a specified mail domain.

    .DESCRIPTION
    The Remove-Domain function deletes a mail domain by making an API call to the specified endpoint. 
    The function uses the domain name provided as input to construct the API request.

    .PARAMETER name
    The name of the mail domain to be removed. This parameter is mandatory.

    .EXAMPLE
    Remove-Domain -name "example.com"

    This example removes the mail domain "example.com".
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "Mail domain name")]
        [string] $name
    )
    
    $params = @{
        "URI"    = "/senders/domains/$([uri]::EscapeDataString($name))"
        "Method" = "DELETE"
    } 

    $body = @{
        name = $name
    }
    if ($PSCmdlet.ShouldProcess("$script:graphQLApiUrl")) {
        $Domain = Invoke-BrevoCall @params
        return $Domain
    }
}