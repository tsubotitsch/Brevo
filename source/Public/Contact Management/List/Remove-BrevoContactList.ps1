function Remove-BrevoContactList {
    <#
    .SYNOPSIS
    Removes a contact list by its ID.

    .DESCRIPTION
    The Remove-BrevoContactList function deletes a contact list identified by its unique ID. 
    It sends a DELETE request to the specified URI endpoint.

    .PARAMETER listId
    The ID of the contact list to delete. This parameter is mandatory.

    .EXAMPLE
    Remove-BrevoContactList -listId 12345

    This command deletes the contact list with the ID 12345.
    
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "The ID of the contact list to delete")]
        [int]$listId
    )
    $uri = "/contacts/lists/$listId"
    $method = "DELETE"
    
    $Params = @{
        "URI"    = $uri
        "Method" = $method
    }
    $list = Invoke-BrevoCall @Params
    return $list
}
