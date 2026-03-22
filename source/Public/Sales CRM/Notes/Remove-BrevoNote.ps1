function Remove-BrevoNote
{
    <#
    .SYNOPSIS
        Deletes a note from Brevo CRM.

    .DESCRIPTION
        Permanently deletes a note identified by its ID. Calls DELETE /v3/crm/notes/:id.
        Returns no content on success (HTTP 204).
        Supports -WhatIf and -Confirm via SupportsShouldProcess.

    .PARAMETER Id
        The unique ID of the note to delete.

    .EXAMPLE
        Remove-BrevoNote -Id "61a5cd07ca1347c82306ad09"

    .EXAMPLE
        Remove-BrevoNote -Id "61a5cd07ca1347c82306ad09" -Confirm:$false

    .LINK
        https://developers.brevo.com/reference/delete-a-note
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "High")]
    param (
        # Note ID to delete (path parameter)
        [Parameter(Mandatory)]
        [Alias("NoteId")]
        [string]$Id
    )

    if ($PSCmdlet.ShouldProcess($Id, "Delete Brevo note"))
    {
        $Params = @{
            "URI"    = "/crm/notes/$Id"
            "Method" = "DELETE"
        }
        Invoke-BrevoCall @Params
    }
}
