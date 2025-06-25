
function New-BrevoContactFolder {
    <#
    .SYNOPSIS
    Creates a new contact folder in Brevo.

    .DESCRIPTION
    The New-BrevoContactFolder function creates a new contact folder in Brevo by sending a POST request to the /contacts/folders endpoint.

    .PARAMETER Name
    The name of the contact folder to be created. This parameter is mandatory.

    .EXAMPLE
    PS C:\> New-BrevoContactFolder -Name "MyNewFolder"
    This command creates a new contact folder named "MyNewFolder".

    .OUTPUTS
    The function returns the created contact folder object.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "The name of the contact folder")]
        [string]$Name
    )
    $uri = "/contacts/folders"
    $method = "POST"
    $body = @{
        name = $Name
    }
    $Params = @{
        "URI"    = $uri
        "Method" = $method
        "Body"   = $body
        # "returnobject" = "folders"
    }
    $folder = Invoke-BrevoCall @Params
    if ($folder -and ($folder.id -ne $null)) {
        $folder = Get-BrevoContactFolder -folderId $folder.id
    }
    return $folder
}