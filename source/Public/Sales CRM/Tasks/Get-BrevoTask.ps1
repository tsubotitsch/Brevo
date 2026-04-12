function Get-BrevoTask
{
    <#
    .SYNOPSIS
        Retrieves tasks from Brevo CRM.

    .DESCRIPTION
        The Get-BrevoTask cmdlet retrieves tasks from Brevo CRM. You can retrieve a single task by its ID or list multiple tasks with optional filtering and pagination.

    .PARAMETER Id
        The ID of the specific task to retrieve. This parameter is mandatory when using the ById parameter set.

    .PARAMETER Limit
        The maximum number of tasks to return. Default is 50.

    .PARAMETER Offset
        The number of tasks to skip for pagination. Default is 0.

    .PARAMETER Sort
        The sort order for the results. Valid values are "asc" or "desc".

    .PARAMETER SortBy
        The field to sort by.

    .EXAMPLE
        Get-BrevoTask -Id "task123"

        Retrieves a single task with ID task123.

    .EXAMPLE
        Get-BrevoTask -Limit 10

        Retrieves the first 10 tasks.

    .LINK
        https://developers.brevo.com/reference/get-tasks

    .LINK
        https://developers.brevo.com/reference/get-a-task
    #>
    [CmdletBinding(DefaultParameterSetName = "List")]
    param (
        [Parameter(Mandatory, ParameterSetName = "ById")]
        [Alias("TaskId")]
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

    $uri = "/crm/tasks"
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
