function Remove-BrevoCrmAttribute
{
    <#
    .SYNOPSIS
        Deletes a CRM attribute from Brevo.

    .DESCRIPTION
        Permanently deletes a custom CRM attribute identified by its entity type and attribute name.
        Returns no content on success (HTTP 204).
        Supports -WhatIf and -Confirm via SupportsShouldProcess.

    .PARAMETER Entity
        The entity type the attribute belongs to. Valid values are "deals" and "companies".

    .PARAMETER Attribute
        The name of the attribute to delete.

    .EXAMPLE
        Remove-BrevoCrmAttribute -Entity "deals" -Attribute "custom_field"

    .EXAMPLE
        Remove-BrevoCrmAttribute -Entity "companies" -Attribute "custom_field" -Confirm:$false

    .LINK
        https://developers.brevo.com/reference/delete-an-attribute
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "High")]
    param (
        [Parameter(Mandatory)]
        [ValidateSet("deals", "companies")]
        [string]$Entity,

        [Parameter(Mandatory)]
        [string]$Attribute
    )

    if ($PSCmdlet.ShouldProcess("$Entity/$Attribute", "Delete Brevo CRM attribute"))
    {
        $Params = @{
            "URI"    = "/crm/attributes/$Entity/$Attribute"
            "Method" = "DELETE"
        }
        Invoke-BrevoCall @Params
    }
}
