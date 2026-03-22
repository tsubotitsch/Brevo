function Update-BrevoContactFolder
{
    <#
    .SYNOPSIS
    Updates a contact folder in Brevo.

    .DESCRIPTION
    The Update-BrevoContactFolder function updates the name of an existing contact folder
    in the Brevo platform. This operation requires the folder ID and the new folder name.

    .PARAMETER FolderId
    The ID of the folder to update. This parameter is mandatory.

    .PARAMETER Name
    The new name for the folder. This parameter is mandatory.

    .EXAMPLE
    PS C:\> Update-BrevoContactFolder -FolderId 123 -Name "Updated Folder Name"

    Updates the folder with ID 123 to have the name "Updated Folder Name".

    .OUTPUTS
    Returns $true on success (HTTP 204 No Content), or $null on failure.

    .LINK
    https://developers.brevo.com/reference/updatefolder-1
    #>

    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param (
        [Parameter(Mandatory = $true, HelpMessage = 'Id of the folder')]
        [Alias('FolderId')]
        [int]$Id,

        [Parameter(Mandatory = $true, HelpMessage = 'Name of the folder')]
        [string]$Name
    )

    begin
    {
        $uri = "/contacts/folders/$Id"
        $method = 'PUT'
        $body = @{ name = $Name }

        $Params = @{
            URI    = $uri
            Method = $method
            Body   = $body
        }
    }

    process
    {
        if ($PSCmdlet.ShouldProcess("Folder $Id", 'Update folder name'))
        {
            try
            {
                # API returns 204 No Content on success; if no error is thrown, consider it successful
                Invoke-BrevoCall @Params | Out-Null
                return $true
            }
            catch
            {
                Write-Error $_.Exception.Message
                return $null
            }
        }
    }
}
