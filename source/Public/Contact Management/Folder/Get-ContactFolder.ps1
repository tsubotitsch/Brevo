function Get-ContactFolder {

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