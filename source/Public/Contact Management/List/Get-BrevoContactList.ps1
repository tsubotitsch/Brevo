function Get-BrevoContactList {
    <#
    .SYNOPSIS
    Retrieves contact lists or a specific contact list from Brevo.

    .DESCRIPTION
    The Get-BrevoContactList function retrieves contact lists or a specific contact list based on the provided parameters. 
    It supports filtering by list ID, folder ID, or retrieving all lists with optional pagination and sorting.

    .PARAMETER listId
    The ID of the specific contact list to retrieve. Used with the "ByListId" parameter set.

    .PARAMETER folderId
    The ID of the folder to retrieve contact lists from. Used with the "ByFolderId" parameter set.

    .PARAMETER listName
    The name of the contact list to retrieve.

    .PARAMETER limit
    The maximum number of documents to retrieve per page. Accepts values from 0 to 50. Defaults to 10.

    .PARAMETER offset
    The index of the first document of the page. Defaults to 0.

    .PARAMETER sort
    The sorting criteria for the retrieved contact lists.

    .EXAMPLE
    # Retrieve all contact lists with default pagination
    Get-BrevoContactList

    .EXAMPLE
    # Retrieve a specific contact list by its ID
    Get-BrevoContactList -listId 123

    .EXAMPLE
    # Retrieve contact lists from a specific folder
    Get-BrevoContactList -folderId 456

    .EXAMPLE
    # Retrieve contact lists with pagination
    Get-BrevoContactList -limit 20 -offset 10

    .OUTPUTS
    Returns a list of contact lists or a specific contact list based on the provided parameters.
    #>
    [CmdletBinding(DefaultParameterSetName = "None")]
    param (
        [Parameter(Mandatory = $false, HelpMessage = "The ID of the list", ParameterSetName = "ByListId")]
        [Alias("Id")]
        [int]$listId,
        [Parameter(Mandatory = $false, HelpMessage = "The ID of the folder to retrieve lists from", ParameterSetName = "ByFolderId")]
        [int]$folderId,
        [Parameter(Mandatory = $false, HelpMessage = "The ID of the folder to retrieve lists from", ParameterSetName = "ByFolderId")]
        [Parameter(Mandatory = $false, HelpMessage = "The ID of the folder to retrieve lists from", ParameterSetName = "None")]
        [Alias("Name")]
        [string]$listName,
        [Parameter(Mandatory = $false, ParameterSetName = "None", HelpMessage = "No specific filter applied")]
        [switch]$None,
        [Parameter(Mandatory = $false, HelpMessage = "0 to 50. Defaults to 10. Number of documents per page")]
        [int]$limit,
        [Parameter(Mandatory = $false, HelpMessage = "Number of documents per page. 0 to 50. Defaults to 10")]
        [int]$offset,
        [Parameter(Mandatory = $false, HelpMessage = "Sort the results in the ascending/descending order of record creation. Default order is desc")]
        [ValidateSet("asc", "desc")]
        [string]$sort
    )
    
    $method = "GET"
    if ($listId) {
        $uri = "/contacts/lists/$listId"
        $method = "GET"
    }
    else {
        $uri = "/contacts/lists"
        $method = "GET"
    }
    
    if ($folderId) {
        $uri = "/contacts/folders/$folderId/lists"
    }

    $queryParams = @{}

    if ($limit -ne 0) {
        $queryParams["limit"] = $limit
    }
    
    if ($offset -ne 0) {
        $queryParams["offset"] = $offset
    }

    if (-not [string]::IsNullOrEmpty($sort)) {
        $queryParams["sort"] = $sort
    }
    
    if ($queryParams.Count -gt 0) {
        $queryString = ($queryParams.GetEnumerator() | ForEach-Object { "$($_.Key)=$($_.Value)" }) -join "&"
        $uri = $uri + "?$queryString"
    }

    $params = @{
        "URI"    = $uri
        "Method" = $method
        #        "returnobject" = "lists"
    }
    

    $list = Invoke-BrevoCall @params
    if (-not [string]::IsNullOrEmpty($listName)) {
        $list = $list | Where-Object { $_.name -eq $listName }
    }
    #TODO: Count is wrong if $list is empty
    return $list
}