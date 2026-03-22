function Get-BrevoNote
{
    <#
    .SYNOPSIS
        Retrieves notes from Brevo CRM.

    .DESCRIPTION
        The Get-BrevoNote cmdlet retrieves notes from Brevo CRM. You can retrieve a single note by its ID or list multiple notes with optional filtering and sorting.

    .PARAMETER Id
        The ID of the specific note to retrieve. This parameter is mandatory when using the ById parameter set.

    .PARAMETER Entity
        The type of entity to filter notes by. Valid values are "companies", "deals", "contacts".

    .PARAMETER EntityIds
        Comma-separated list of entity IDs to filter notes by.

    .PARAMETER DateFrom
        The start date for filtering notes (Unix timestamp).

    .PARAMETER DateTo
        The end date for filtering notes (Unix timestamp).

    .PARAMETER Offset
        The number of notes to skip for pagination.

    .PARAMETER Limit
        The maximum number of notes to return. Default is 50.

    .PARAMETER Sort
        The sort order for the results. Valid values are "asc" or "desc".

    .EXAMPLE
        Get-BrevoNote -Id "12345"

        Retrieves a single note with ID 12345.

    .EXAMPLE
        Get-BrevoNote -Entity "contacts" -Limit 10

        Retrieves up to 10 notes associated with contacts.

    .EXAMPLE
        Get-BrevoNote -Entity "deals" -DateFrom 1640995200 -DateTo 1641081600 -Sort "desc"

        Retrieves notes for deals within a specific date range, sorted in descending order.

    .LINK
        https://developers.brevo.com/reference/get-a-note

    .LINK
        https://developers.brevo.com/reference/get-all-notes
    #>
    [CmdletBinding(DefaultParameterSetName = "List")]
    param (
        # ParameterSet: einzelne Note per ID
        [Parameter(Mandatory, ParameterSetName = "ById")]
        [Alias("NoteId")]
        [string]$Id,

        # ParameterSet: Liste / Suche
        [Parameter(ParameterSetName = "List")]
        [ValidateSet("companies", "deals", "contacts")]
        [string]$Entity,

        [Parameter(ParameterSetName = "List")]
        [string]$EntityIds,

        [Parameter(ParameterSetName = "List")]
        [long]$DateFrom,

        [Parameter(ParameterSetName = "List")]
        [long]$DateTo,

        [Parameter(ParameterSetName = "List")]
        [long]$Offset,

        [Parameter(ParameterSetName = "List")]
        [long]$Limit = 50,

        [Parameter(ParameterSetName = "List")]
        [ValidateSet("asc", "desc")]
        [string]$Sort
    )
    $uri = "/crm/notes/"
    switch ($PSCmdlet.ParameterSetName)
    {
        "ById"
        {
            $uri += "$Id"
        }

        "List"
        {

            $queryParams = [System.Collections.Generic.List[string]]::new()

            if ($PSBoundParameters.ContainsKey("Entity"))
            {
                $queryParams.Add("entity=$Entity") 
            }
            if ($PSBoundParameters.ContainsKey("EntityIds"))
            {
                $queryParams.Add("entityIds=$EntityIds") 
            }
            if ($PSBoundParameters.ContainsKey("DateFrom"))
            {
                $queryParams.Add("dateFrom=$DateFrom") 
            }
            if ($PSBoundParameters.ContainsKey("DateTo"))
            {
                $queryParams.Add("dateTo=$DateTo") 
            }
            if ($PSBoundParameters.ContainsKey("Offset"))
            {
                $queryParams.Add("offset=$Offset") 
            }
            if ($PSBoundParameters.ContainsKey("Limit"))
            {
                $queryParams.Add("limit=$Limit") 
            }
            if ($PSBoundParameters.ContainsKey("Sort"))
            {
                $queryParams.Add("sort=$Sort") 
            }

            if ($queryParams.Count -gt 0)
            {
                $uri = "$uri`?$($queryParams -join '&')"
            }

        }
    }
    $Params = @{
        "URI"    = $uri
        "Method" = "GET"
    }
    Invoke-BrevoCall @Params
}
