function Get-BrevoContactSegment {
    <#
    .SYNOPSIS
    Retrieves contact segments from the Brevo API.

    .DESCRIPTION
    The Get-BrevoContactSegment function retrieves contact segments from the Brevo API. 
    It allows you to specify the number of results per page, the starting index for pagination, 
    and the sort order of the results.

    .PARAMETER limit
    The number of results returned per page. The default is 10, and the maximum is 50.

    .PARAMETER offset
    The index of the first document in the page (starting with 0). For example, if the limit is 50 
    and you want to retrieve page 2, then offset=50.

    .PARAMETER sort
    Sorts the results in the ascending ("asc") or descending ("desc") order of record creation. 
    The default order is descending if this parameter is not specified.

    .EXAMPLE
    Get-BrevoContactSegment -limit 20 -offset 0 -sort "asc"
    Retrieves the first 20 contact segments sorted in ascending order.

    .EXAMPLE
    Get-BrevoContactSegment -limit 50 -offset 100
    Retrieves 50 contact segments starting from the 101st record, sorted in descending order.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, HelpMessage = "The number of results returned per page. The default is 10. The maximum is 50")]
        [int]$limit = 10,
        [Parameter(Mandatory = $false, HelpMessage = "The index of the first document in the page (starting with 0). For example, if the limit is 50 and you want to retrieve the page 2, then offset=50")]
        [int]$offset = 0,
        [Parameter(Mandatory = $false, HelpMessage = "Sort the results in the ascending/descending order of record creation. Default order is descending if sort is not passed")]
        [ValidateSet ("asc", "desc")]
        [string]$sort = "desc"
    )
    $method = "GET"
    $uri = "/contacts/segments"
    #$returnobject = "segments"

    $queryParams = @{}

    if ($null -ne $limit) {
        $queryParams["limit"] = $limit
    }
    
    if ($null -ne $offset) {
        $queryParams["offset"] = $offset
    }
    
    if ($queryParams.Count -gt 0) {
        $queryString = ($queryParams.GetEnumerator() | ForEach-Object { "$($_.Key)=$($_.Value)" }) -join "&"
        $uri = $uri + "?$queryString"
    }

    $Params = @{
        "URI"          = $uri
        "Method"       = $method
#        "returnobject" = $returnobject
    }
    
    $folder = Invoke-BrevoCall @Params
    return $folder
}