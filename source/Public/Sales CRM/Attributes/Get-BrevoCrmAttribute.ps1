function Get-BrevoCrmAttribute
{
    <#
    .SYNOPSIS
        Retrieves CRM attributes for deals or companies.

    .DESCRIPTION
        The Get-BrevoCrmAttribute cmdlet retrieves custom attributes for CRM resources, specifically for deals and companies.

    .PARAMETER Entity
        The entity type to retrieve attributes for. Valid values are "deals" and "companies". This parameter is mandatory.

    .EXAMPLE
        Get-BrevoCrmAttribute -Entity "deals"

        Retrieves all custom attributes for deals.

    .EXAMPLE
        Get-BrevoCrmAttribute -Entity "companies"

        Retrieves all custom attributes for companies.

    .LINK
        https://developers.brevo.com/reference/get-attributes
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, HelpMessage = "Entity type for which to retrieve attributes")]
        [ValidateSet("deals", "companies")]
        [string]$Entity
    )

    $uri = "/crm/attributes/$Entity"

    $Params = @{
        "URI"    = $uri
        "Method" = "GET"
    }

    Invoke-BrevoCall @Params
}
