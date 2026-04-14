function Set-BrevoCompanyLink
{
    <#
    .SYNOPSIS
        Links or unlinks contacts and deals to/from a company in Brevo CRM.

    .DESCRIPTION
        This cmdlet allows you to establish or remove links between a company and contacts or deals.

    .PARAMETER Id
        The unique ID of the company. This parameter is mandatory.

    .PARAMETER LinkContactIds
        An array of contact IDs to link to the company.

    .PARAMETER UnlinkContactIds
        An array of contact IDs to unlink from the company.

    .PARAMETER LinkDealIds
        An array of deal IDs to link to the company.

    .PARAMETER UnlinkDealIds
        An array of deal IDs to unlink from the company.

    .EXAMPLE
        Set-BrevoCompanyLink -Id "123456" -LinkContactIds @(1, 2, 3)

        Links three contacts to a company.

    .EXAMPLE
        Set-BrevoCompanyLink -Id "123456" -UnlinkDealIds @("deal1", "deal2")

        Unlinks two deals from a company.

    .LINK
        https://developers.brevo.com/reference/link-unlink-a-company
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "Medium")]
    param (
        [Parameter(Mandatory)]
        [Alias("CompanyId")]
        [string]$Id,

        [Parameter()]
        [int[]]$LinkContactIds,

        [Parameter()]
        [int[]]$UnlinkContactIds,

        [Parameter()]
        [string[]]$LinkDealIds,

        [Parameter()]
        [string[]]$UnlinkDealIds
    )

    $uri = "/companies/link-unlink/$Id"

    $body = @{}

    if ($PSBoundParameters.ContainsKey("LinkContactIds"))
    {
        $body.linkContactIds = $LinkContactIds
    }
    if ($PSBoundParameters.ContainsKey("UnlinkContactIds"))
    {
        $body.unlinkContactIds = $UnlinkContactIds
    }
    if ($PSBoundParameters.ContainsKey("LinkDealIds"))
    {
        $body.linkDealIds = $LinkDealIds
    }
    if ($PSBoundParameters.ContainsKey("UnlinkDealIds"))
    {
        $body.unlinkDealIds = $UnlinkDealIds
    }

    if ($PSCmdlet.ShouldProcess($Id, "Update company links"))
    {
        $Params = @{
            "URI"    = $uri
            "Method" = "PATCH"
            "Body"   = $body
        }

        Invoke-BrevoCall @Params
    }
}
