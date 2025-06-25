function New-BrevoContactList {
    <#
    .SYNOPSIS
    Creates a new contact list in Brevo.

    .DESCRIPTION
    The New-BrevoContactList function creates a new contact list in Brevo by specifying the name of the contact list and the ID of the folder in which the contact list is created.

    .PARAMETER Name
    The name of the contact list.

    .PARAMETER FolderId
    The ID of the folder in which the contact list is created.

    .EXAMPLE
    $contactList = New-BrevoContactList -Name "My New List" -FolderId 123
    Creates a new contact list named "My New List" in the folder with ID 123.

    .OUTPUTS
    The created contact list object.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "The name of the contact list")]
        [string]$Name,
        [Parameter(Mandatory = $true, HelpMessage = "The ID of the folder in which the contact list is created")]
        $FolderId
    )
    $uri = "/contacts/lists"
    $method = "POST"
    
    $body = @{
        name = $Name
        folderId = $FolderId
    }
    $Params = @{
        "URI"    = $uri
        "Method" = $method
        "Body"   = $body
        "returnobject" = "lists"
    }

    try {
        Invoke-BrevoCall @Params
        $params = @{
            Name = $Name
        }
        if ($null -ne $FolderId) {
            $params.FolderId = $FolderId
        }
        $list = Get-BrevoContactList @params
    }
    catch {
    }
    return $list    
}
