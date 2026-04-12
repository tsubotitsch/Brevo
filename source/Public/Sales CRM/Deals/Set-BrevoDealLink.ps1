function Set-BrevoDealLink
{
    <#
    .SYNOPSIS
        Links or unlinks contacts and companies to/from a deal in Brevo CRM.

    .DESCRIPTION
        This cmdlet allows you to establish or remove links between a deal and contacts or companies.

    .PARAMETER Id
        The unique ID of the deal. This parameter is mandatory.

    .PARAMETER LinkContactIds
        An array of contact IDs to link to the deal.

    .PARAMETER UnlinkContactIds
        An array of contact IDs to unlink from the deal.

    .PARAMETER LinkCompanyIds
        An array of company IDs to link to the deal.

    .PARAMETER UnlinkCompanyIds
        An array of company IDs to unlink from the deal.

    .EXAMPLE
        Set-BrevoDealLink -Id "deal123" -LinkContactIds @(1, 2)

        Links two contacts to a deal.

    .EXAMPLE
        Set-BrevoDealLink -Id "deal123" -UnlinkCompanyIds @("company1")

        Unlinks a company from a deal.

    .LINK
        https://developers.brevo.com/reference/link-unlink-a-deal
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [Alias("DealId")]
        [string]$Id,

        [Parameter()]
        [int[]]$LinkContactIds,

        [Parameter()]
        [int[]]$UnlinkContactIds,

        [Parameter()]
        [string[]]$LinkCompanyIds,

        [Parameter()]
        [string[]]$UnlinkCompanyIds
    )

    $uri = "/crm/deals/link-unlink/$Id"

    $body = @{}

    if ($PSBoundParameters.ContainsKey("LinkContactIds"))
    {
        $body.linkContactIds = $LinkContactIds
    }
    if ($PSBoundParameters.ContainsKey("UnlinkContactIds"))
    {
        $body.unlinkContactIds = $UnlinkContactIds
    }
    if ($PSBoundParameters.ContainsKey("LinkCompanyIds"))
    {
        $body.linkCompanyIds = $LinkCompanyIds
    }
    if ($PSBoundParameters.ContainsKey("UnlinkCompanyIds"))
    {
        $body.unlinkCompanyIds = $UnlinkCompanyIds
    }

    $Params = @{
        "URI"    = $uri
        "Method" = "PATCH"
        "Body"   = $body
    }

    Invoke-BrevoCall @Params
}
