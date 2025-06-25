function Get-BrevoContactFolder {
    <#
    .SYNOPSIS
        Retrieves contact folder(s) from the Brevo API.

    .DESCRIPTION
        The Get-BrevoContactFolder function retrieves one or more contact folders from the Brevo API.
        You can retrieve a specific folder by its ID, filter by folder name, or list folders with optional pagination and sorting.

    .PARAMETER folderId
        The ID of the folder to retrieve. If specified, retrieves a single folder by its ID.

    .PARAMETER Name
        The name of the folder to retrieve. If specified, filters the results to folders matching the given name.

    .PARAMETER None
        Reserved for future use. Currently has no effect.

    .PARAMETER limit
        The number of documents per page (0 to 50). Defaults to 10 if not specified.

    .PARAMETER offset
        The number of documents to skip before starting to collect the result set. Defaults to 0.

    .PARAMETER sort
        Sorts the results in ascending ("asc") or descending ("desc") order of record creation. The default order is "desc".

    .EXAMPLE
        Get-BrevoContactFolder -folderId 123

        Retrieves the contact folder with ID 123.

    .EXAMPLE
        Get-BrevoContactFolder -limit 20 -offset 10 -sort asc

        Retrieves a paginated list of contact folders, 20 per page, skipping the first 10, sorted in ascending order.

    .EXAMPLE
        Get-BrevoContactFolder -Name "Marketing"

        Retrieves contact folders with the name "Marketing".

    #>
    [CmdletBinding(DefaultParameterSetName = "None")]
    param (
        [Parameter(Mandatory = $false, HelpMessage = "The ID of the folder", ParameterSetName = "ByFolderId")]
        [int]$folderId,
        [Parameter(Mandatory = $false, HelpMessage = "The name of the folder to retrieve", ParameterSetName = "ByFolderName")]
        [string]$Name,
        [Parameter(Mandatory = $false)]
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

    if ($folderId) {
        $uri = "/contacts/folders/$folderId"
    }
    else {
        $uri = "/contacts/folders"
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
    
    #$returnobject = "folders"

    $Params = @{
        "URI"    = $uri
        "Method" = $method
        # "returnobject" = $returnobject
    }
    
    $folders = Invoke-BrevoCall @Params

    if ($Name) {
        $folders = $folders | Where-Object { $_.name -eq $Name }
    }

    return $folders
}
