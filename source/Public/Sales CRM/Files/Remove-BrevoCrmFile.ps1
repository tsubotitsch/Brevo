function Remove-BrevoCrmFile
{
    <#
    .SYNOPSIS
        Deletes a file from Brevo CRM.

    .DESCRIPTION
        Permanently deletes a file identified by its ID.
        Returns no content on success (HTTP 204).
        Supports -WhatIf and -Confirm via SupportsShouldProcess.

    .PARAMETER Id
        The unique ID of the file to delete.

    .EXAMPLE
        Remove-BrevoCrmFile -Id "file123"

    .EXAMPLE
        Remove-BrevoCrmFile -Id "file123" -Confirm:$false

    .LINK
        https://developers.brevo.com/reference/delete-a-file
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "High")]
    param (
        [Parameter(Mandatory)]
        [Alias("FileId")]
        [string]$Id
    )

    if ($PSCmdlet.ShouldProcess($Id, "Delete Brevo CRM file"))
    {
        $Params = @{
            "URI"    = "/crm/files/$Id"
            "Method" = "DELETE"
        }
        Invoke-BrevoCall @Params
    }
}
