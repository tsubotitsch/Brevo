function Remove-BrevoTask
{
    <#
    .SYNOPSIS
        Deletes a task from Brevo CRM.

    .DESCRIPTION
        Permanently deletes a task identified by its ID.
        Returns no content on success (HTTP 204).
        Supports -WhatIf and -Confirm via SupportsShouldProcess.

    .PARAMETER Id
        The unique ID of the task to delete.

    .EXAMPLE
        Remove-BrevoTask -Id "task123"

    .EXAMPLE
        Remove-BrevoTask -Id "task123" -Confirm:$false

    .LINK
        https://developers.brevo.com/reference/delete-a-task
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "High")]
    param (
        [Parameter(Mandatory)]
        [Alias("TaskId")]
        [string]$Id
    )

    if ($PSCmdlet.ShouldProcess($Id, "Delete Brevo task"))
    {
        $Params = @{
            "URI"    = "/crm/tasks/$Id"
            "Method" = "DELETE"
        }
        Invoke-BrevoCall @Params
    }
}
