function Update-BrevoContactList {
    <#
    .SYNOPSIS
    Updates a contact list by modifying its name or moving it to a different folder.

    .DESCRIPTION
    The `Update-BrevoContactList` function allows you to update the properties of an existing contact list. 
    You can either update the name of the list or move it to a different folder by specifying the folder ID. 
    Only one of these properties (name or folderId) can be updated at a time.

    .PARAMETER listId
    The ID of the contact list to update. This parameter is mandatory.

    .PARAMETER Name
    The new name for the contact list. This parameter is optional. 
    If specified, the list's name will be updated.

    .PARAMETER folderid
    The ID of the folder to which the contact list should be moved. This parameter is optional. 
    If specified, the list will be moved to the specified folder.

    .EXAMPLE
    Update-BrevoContactList -listId 123 -Name "New List Name"
    
    Update the name of a contact list with ID 123

    .EXAMPLE
    Update-BrevoContactList -listId 456 -folderid 789
    
    Move a contact list with ID 456 to a folder with ID 789
    
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "The ID of the contact list to update")]
        [int]$listId,

        [Parameter(Mandatory = $false, HelpMessage = "Name of the list. Either of the two parameters (name, folderId) can be updated at a time.")]
        [string]$Name,

        [Parameter(Mandatory = $false, HelpMessage = "Id of the folder in which the list is to be moved. Either of the two parameters (name, folderId) can be updated at a time.")]
        [int]$folderid
    )
    $uri = "/contacts/lists/$listId"
    $method = "PUT"
    
    $body = @{}

    if ($Name) {
        $body.name = $Name
    }
    if ($folderid) {
        $body.folderId = $folderid
    }

    $Params = @{
        "URI"          = $uri
        "Method"       = $method
        "Body"         = $body
        }
    $list = Invoke-BrevoCall @Params
    return $list
}
