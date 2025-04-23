function Get-Contact {
    <#
    .SYNOPSIS
    Retrieves contact information from the Brevo API based on specified parameters.

    .DESCRIPTION
    The Get-Contact function is used to fetch contact details from the Brevo API. 
    It supports various filters and query parameters to customize the results, 
    such as filtering by ID, creation/modification date, list IDs, segment IDs, 
    and sorting options.

    .PARAMETER Id
    The unique identifier for the contact. This can be an email ID (for EMAIL), 
    phone ID (for SMS), or contact ID.

    .PARAMETER limit
    Specifies the number of documents per page. Acceptable values are between 0 and 50. 
    Defaults to 10 if not specified.

    .PARAMETER offset
    Specifies the number of documents to skip. Acceptable values are between 0 and 50. 
    Defaults to 10 if not specified.

    .PARAMETER sort
    Sorts the results in ascending ("asc") or descending ("desc") order of record creation. 
    The default order is "desc".

    .PARAMETER modifiedSince
    Filters the contacts modified after a given date-time (local time). 
    The date-time should be URL-encoded.

    .PARAMETER createdSince
    Filters the contacts created after a given date-time (local time). 
    The date-time should be URL-encoded.

    .PARAMETER segmentId
    Filters the contacts by the ID of the segment. Either `listId` or `segmentId` can be passed.

    .PARAMETER listId
    Filters the contacts by the ID(s) of the list(s). Accepts an array of integers.

    .PARAMETER filter
    Filters the contacts based on attributes. The allowed operator is `equals`. 
    For multiple-choice options, the filter applies an AND condition between the options. 
    For category attributes, the filter works with both ID and value. 
    Examples:
    - `filter=equals(FIRSTNAME,"Antoine")`
    - `filter=equals(B1, true)`
    - `filter=equals(DOB, "1989-11-23")`
    - `filter=equals(GENDER, "1")`
    - `filter=equals(GENDER, "MALE")`
    - `filter=equals(COUNTRY,"USA, INDIA")`

    .EXAMPLE
    # Retrieve a contact by ID
    Get-Contact -Id "12345"

    .EXAMPLE
    # Retrieve contacts created since a specific date
    Get-Contact -createdSince "2023-01-01"

    .EXAMPLE
    # Retrieve contacts with a specific filter
    Get-Contact -filter 'equals(FIRSTNAME,"John")'

    .NOTES
    This function constructs a query string based on the provided parameters and 
    makes a GET request to the Brevo API using the Invoke-BrevoCall function.

    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, HelpMessage = "ID is email_id (for EMAIL), phone_id (for SMS) or contact_id (for ID of the contact)")]
        [string]$Id,
        [Parameter(Mandatory = $false, HelpMessage = "0 to 50. Defaults to 10. Number of documents per page")]
        [int]$limit,
        [Parameter(Mandatory = $false, HelpMessage = "Number of documents per page. 0 to 50. Defaults to 10")]
        [int]$offset,
        [Parameter(Mandatory = $false, HelpMessage = "Sort the results in the ascending/descending order of record creation. Default order is desc")]
        [ValidateSet("asc", "desc")]
        [string]$sort,
        [Parameter(Mandatory = $false, HelpMessage = "Filter (urlencoded) the contacts modified after a given date-time (local time)")]
        $modifiedSince,
        [Parameter(Mandatory = $false, HelpMessage = "Filter (urlencoded) the contacts created after a given date-time (local time)")]
        $createdSince,
        [Parameter(Mandatory = $false, HelpMessage = "Id of the segment. Either listIds or segmentId can be passed.")]
        [int]$segmentId,
        [Parameter(Mandatory = $false, HelpMessage = "Id of the list(s).")]
        [int[]]$listId,
        [Parameter(Mandatory = $false, HelpMessage = 'Filter the contacts on the basis of attributes. Allowed operator: equals. For multiple-choice options, the filter will apply an AND condition between the options. For category attributes, the filter will work with both id and value. (e.g. filter=equals(FIRSTNAME,"Antoine"), filter=equals(B1, true), filter=equals(DOB, "1989-11-23"), filter=equals(GENDER, "1"), filter=equals(GENDER, "MALE"), filter=equals(COUNTRY,"USA, INDIA")')]
        [string]$filter
    )
    $uri = "/contacts/$Id"
    $method = "GET"
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

    if ($null -ne $modifiedSince) {
        $queryParams["modifiedSince"] = [System.Web.HttpUtility]::UrlEncode((Get-Date $modifiedSince).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss.fffZ"))
    }

    if ($null -ne $createdSince) {
        $queryParams["createdSince"] = [System.Web.HttpUtility]::UrlEncode((Get-Date $createdSince).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss.fffZ"))
    }

    if ($segmentId -ne 0) {
        $queryParams["segmentId"] = $segmentId
    }

    if ($listId -is [Array]) {
        $queryParams["listId"] = $listId -join ","
    }
    
    if ($queryParams.Count -gt 0) {
        $queryString = ($queryParams.GetEnumerator() | ForEach-Object { "$($_.Key)=$($_.Value)" }) -join "&"
        $uri = $uri + "?$queryString"
    }

    $Params = @{
        "URI"    = $uri
        "Method" = $method
    }
    $contact = Invoke-BrevoCall @Params
    return $contact
}