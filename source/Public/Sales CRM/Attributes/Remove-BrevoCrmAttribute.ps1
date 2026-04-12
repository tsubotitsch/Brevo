function Remove-BrevoCrmAttribute
{
    <#
    .SYNOPSIS
        Deletes a CRM attribute from Brevo.

    .DESCRIPTION
        Permanently deletes a custom CRM attribute identified by its name.
        Returns no content on success (HTTP 204).
        Supports -WhatIf and -Confirm via SupportsShouldProcess.

    .PARAMETER Attribute
        The name of the attribute to delete.

    .EXAMPLE
        Remove-BrevoCrmAttribute -Attribute "custom_field"

    .EXAMPLE
        Remove-BrevoCrmAttribute -Attribute "custom_field" -Confirm:$false

    .LINK
        https://developers.brevo.com/reference/delete-an-attribute
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "High")]
    param (
        [Parameter(Mandatory)]
        [string]$Attribute
    )

    if ($PSCmdlet.ShouldProcess($Attribute, "Delete Brevo CRM attribute"))
    {
        $Params = @{
            "URI"    = "/crm/attributes/$Attribute"
            "Method" = "DELETE"
        }
        Invoke-BrevoCall @Params
    }
}
