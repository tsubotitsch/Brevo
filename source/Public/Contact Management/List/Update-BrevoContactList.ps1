function Update-BrevoContactList
{
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
    PS> Update-BrevoContactList -listId 123 -Name "New List Name"

    Update the name of a contact list with ID 123.

    .EXAMPLE
    PS> @(
    @{ listId = 123; Name = "Updated List 1" },
    @{ listId = 456; folderid = 789 }
    ) | Update-BrevoContactList

    This example demonstrates updating multiple contact lists by passing their properties through the pipeline.
    
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "The ID of the contact list to update", ValueFromPipelineByPropertyName = $true)]
        [ValidateRange(1, [int]::MaxValue)]
        [int]$listId,

        [Parameter(Mandatory = $false, HelpMessage = "Name of the list. Either of the two parameters (name, folderId) can be updated at a time.", ValueFromPipelineByPropertyName = $true)]
        [string]$Name,

        [Parameter(Mandatory = $false, HelpMessage = "Id of the folder in which the list is to be moved. Either of the two parameters (name, folderId) can be updated at a time.", ValueFromPipelineByPropertyName = $true)]
        [ValidateRange(1, [int]::MaxValue)]
        [int]$folderid
    )
    begin
    {
        $method = "PUT"
    }
    process
    {
        
        $uri = "/contacts/lists/$listId"
        
        $body = @{}

        # if neither is specified, create a warning and exit
        if ((-not $Name) -and (-not $folderid))
        {
            Write-Warning "At least one of the parameters (Name or folderId) must be specified to update the contact list."
            return
        }
    
        if ($Name)
        {
            $body.name = $Name
        }
        if ($folderid)
        {
            $body.folderId = $folderid
        }

    
        $Params = @{
            "URI"    = $uri
            "Method" = $method
            "Body"   = $body
        }
        $list = Invoke-BrevoCall @Params
        return $list
    }
}
