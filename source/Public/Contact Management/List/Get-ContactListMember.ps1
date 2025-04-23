
function Get-ContactListMember {
    <#
    .SYNOPSIS
    Retrieves members of a specified contact list.

    .DESCRIPTION
    The Get-ContactListMember function retrieves the members of a contact list based on the provided list ID. 
    Optional parameters allow filtering by modification date, limiting the number of results, specifying an offset, 
    and sorting the results.

    .PARAMETER listId
    The ID of the contact list to retrieve members from. This parameter is mandatory.

    .PARAMETER modifiedSince
    Filters the contacts modified after a given UTC date-time (YYYY-MM-DDTHH:mm:ss.SSSZ). 
    It is recommended to pass your timezone in date-time format for accurate results. This parameter is optional.

    .PARAMETER limit
    Specifies the number of documents per page. Acceptable values are between 0 and 500. Defaults to 50 if not provided. This parameter is optional.

    .PARAMETER offset
    Specifies the index of the first document of the page. This parameter is optional.

    .PARAMETER sort
    Sorts the results in ascending or descending order of record creation. 
    If not provided, the default order is descending. This parameter is optional.

    .EXAMPLE
    Get-ContactListMember -listId 12345 -modifiedSince "2023-01-01T00:00:00.000Z" -limit 100 -offset 0 -sort "asc"

    This example retrieves up to 100 members of the contact list with ID 12345, modified after January 1, 2023, 
    starting from the first record, sorted in ascending order.

    .RETURNS
    Returns the list of contacts retrieved from the specified contact list.

    .NOTES
    This function uses the Invoke-BrevoCall cmdlet to make the API call to retrieve the contact list members.
    Ensure that the Invoke-BrevoCall cmdlet is properly configured and available in your environment.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "The ID of the contact list to update")]
        [int]$listId,
        [Parameter(Mandatory = $false, HelpMessage = "Filter (urlencoded) the contacts modified after a given UTC date-time (YYYY-MM-DDTHH:mm:ss.SSSZ). Prefer to pass your timezone in date-time format for accurate result.")]
        [string]$modifiedSince,
        [Parameter(Mandatory = $false, HelpMessage = "0 to 500. Defaults to 50 Number of documents per page")]
        [int]$limit,
        [Parameter(Mandatory = $false, HelpMessage = "Index of the first document of the page")]
        [int]$offset,
        [Parameter(Mandatory = $false, HelpMessage = "Sort the results in the ascending/descending order of record creation. Default order is descending if sort is not passed")]
        [string]$sort

    )
    $uri = "/contacts/lists/$listId/contacts"
    $method = "GET"

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

    $Params = @{
        "URI"    = $uri
        "Method" = $method
    }
    $contacts = Invoke-BrevoCall @Params
    return $contacts
}