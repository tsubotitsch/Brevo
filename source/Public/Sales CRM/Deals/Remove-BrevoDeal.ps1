function Remove-BrevoDeal
{
    <#
    .SYNOPSIS
        Deletes a deal from Brevo CRM.

    .DESCRIPTION
        Permanently deletes a deal identified by its ID.
        Returns no content on success (HTTP 204).
        Supports -WhatIf and -Confirm via SupportsShouldProcess.

    .PARAMETER Id
        The unique ID of the deal to delete.

    .EXAMPLE
        Remove-BrevoDeal -Id "deal123"

    .EXAMPLE
        Remove-BrevoDeal -Id "deal123" -Confirm:$false

    .LINK
        https://developers.brevo.com/reference/delete-a-deal
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "High")]
    param (
        [Parameter(Mandatory)]
        [Alias("DealId")]
        [string]$Id
    )

    if ($PSCmdlet.ShouldProcess($Id, "Delete Brevo deal"))
    {
        $Params = @{
            "URI"    = "/crm/deals/$Id"
            "Method" = "DELETE"
        }
        Invoke-BrevoCall @Params
    }
}
