function Remove-BrevoCompany
{
    <#
    .SYNOPSIS
        Deletes a company from Brevo CRM.

    .DESCRIPTION
        Permanently deletes a company identified by its ID.
        Returns no content on success (HTTP 204).
        Supports -WhatIf and -Confirm via SupportsShouldProcess.

    .PARAMETER Id
        The unique ID of the company to delete.

    .EXAMPLE
        Remove-BrevoCompany -Id "123456"

    .EXAMPLE
        Remove-BrevoCompany -Id "123456" -Confirm:$false

    .LINK
        https://developers.brevo.com/reference/delete-company
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "High")]
    param (
        [Parameter(Mandatory)]
        [Alias("CompanyId")]
        [string]$Id
    )

    if ($PSCmdlet.ShouldProcess($Id, "Delete Brevo company"))
    {
        $Params = @{
            "URI"    = "/companies/$Id"
            "Method" = "DELETE"
        }
        Invoke-BrevoCall @Params
    }
}
