function Get-BrevoDeal
{
    <#
    .SYNOPSIS
        Retrieves deals from Brevo CRM.

    .DESCRIPTION
        The Get-BrevoDeal cmdlet retrieves deals from Brevo CRM. You can retrieve a single deal by its ID or list multiple deals with optional filtering and pagination.

    .PARAMETER Id
        The ID of the specific deal to retrieve. This parameter is mandatory when using the ById parameter set.

    .PARAMETER Limit
        The maximum number of deals to return. Default is 50.

    .PARAMETER Offset
        The number of deals to skip for pagination. Default is 0.

    .PARAMETER Sort
        The sort order for the results. Valid values are "asc" or "desc".

    .PARAMETER SortBy
        The field to sort by.

    .EXAMPLE
        Get-BrevoDeal -Id "deal123"

        Retrieves a single deal with ID deal123.

    .EXAMPLE
        Get-BrevoDeal -Limit 10 -Offset 0

        Retrieves the first 10 deals.

    .LINK
        https://developers.brevo.com/reference/get-deals

    .LINK
        https://developers.brevo.com/reference/get-a-deal
    #>
    [CmdletBinding(DefaultParameterSetName = "List")]
    param (
        [Parameter(Mandatory, ParameterSetName = "ById")]
        [Alias("DealId")]
        [string]$Id,

        [Parameter(ParameterSetName = "List")]
        [long]$Limit = 50,

        [Parameter(ParameterSetName = "List")]
        [long]$Offset = 0,

        [Parameter(ParameterSetName = "List")]
        [ValidateSet("asc", "desc")]
        [string]$Sort,

        [Parameter(ParameterSetName = "List")]
        [string]$SortBy
    )

    $uri = "/crm/deals"
    switch ($PSCmdlet.ParameterSetName)
    {
        "ById"
        {
            $uri += "/$Id"
        }

        "List"
        {
            $queryParams = [System.Collections.Generic.List[string]]::new()

            if ($PSBoundParameters.ContainsKey("Limit"))
            {
                $queryParams.Add("limit=$Limit")
            }
            if ($PSBoundParameters.ContainsKey("Offset"))
            {
                $queryParams.Add("offset=$Offset")
            }
            if ($PSBoundParameters.ContainsKey("Sort"))
            {
                $queryParams.Add("sort=$Sort")
            }
            if ($PSBoundParameters.ContainsKey("SortBy"))
            {
                $queryParams.Add("sortBy=$SortBy")
            }

            if ($queryParams.Count -gt 0)
            {
                $uri += "?" + ($queryParams -join "&")
            }
        }
    }

    $Params = @{
        "URI"    = $uri
        "Method" = "GET"
    }

    Invoke-BrevoCall @Params
}
