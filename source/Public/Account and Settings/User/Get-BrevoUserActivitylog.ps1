function Get-BrevoUserActivitylog {
    <#
    .SYNOPSIS
    Get user activity logs. (requires Enterprise plan)

    .DESCRIPTION
    The Get-BrevoUserActivitylog function retrieves activity logs for users in the account. 
    You can filter the logs by date range, email address, and pagination parameters such as limit and offset. 
    The maximum time period that can be selected is one month, and logs from the past 12 months can be retrieved.

    .PARAMETER startDate
    Optional. The start date in UTC date (YYYY-MM-DD) format to filter the activity logs. 
    Mandatory if the endDate parameter is used.

    .PARAMETER endDate
    Optional. The end date in UTC date (YYYY-MM-DD) format to filter the activity logs. 
    Mandatory if the startDate parameter is used.

    .PARAMETER email
    Optional. The email address of the user to filter their activity logs.

    .PARAMETER limit
    Optional. The maximum number of records to retrieve. 
    Defaults to 10. Acceptable values range from 1 to 100.

    .PARAMETER offset
    Optional. The number of records to skip before starting to retrieve records. 
    Defaults to 0.

    .EXAMPLE
    Get-BrevoUserActivitylog -startDate "2023-01-01" -endDate "2023-01-31" -email "user@example.com" -limit 20 -offset 0

    This example retrieves the activity logs for the user with the email "user@example.com" 
    for the date range from January 1, 2023, to January 31, 2023, with a maximum of 20 records starting from the first record.

    .EXAMPLE
    Get-BrevoUserActivitylog -limit 50

    This example retrieves up to 50 activity logs without any specific filters.

    #>    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, HelpMessage = "Mandatory if endDate is used. Enter start date in UTC date (YYYY-MM-DD) format to filter the activity in your account. Maximum time period that can be selected is one month. Additionally, you can retrieve activity logs from the past 12 months from the date of your search.")]
        [string]$startDate,
        [Parameter(Mandatory = $false, HelpMessage = "Mandatory if startDate is used. Enter end date in UTC date (YYYY-MM-DD) format to filter the activity in your account. Maximum time period that can be selected is one month.")]
        [string]$endDate,
        [Parameter(Mandatory = $false, HelpMessage = "Enter the user's email address to filter their activity in the account.")]
        [string]$email,
        [Parameter(Mandatory = $false, HelpMessage = "1 to 100
Defaults to 10")]
        [int] $limit,
        [Parameter(Mandatory = $false, HelpMessage = "Defaults to 0")]
        [int] $offset = 0
    )
    
    $params = @{
        "URI"    = "/organization/activities"
        "Method" = "GET"
    }

    if ($startDate) {
        $params["URI"] = $params["URI"] + "?startDate=$startDate"
        if ($endDate) {
            $params["URI"] = $params["URI"] + "&endDate=$endDate"
        }
    }
    if ($email) {
        if ($params["URI"] -like "*?*") {
            # URI enthält bereits ein ?
            $params["URI"] = $params["URI"] + "&email=$([uri]::EscapeDataString($email))"
        }
        else {
            # URI enthält noch kein ?
            $params["URI"] = $params["URI"] + "?email=$([uri]::EscapeDataString($email))"
        }
    }
    if ($limit) {
        if ($params["URI"] -like "*?*") {
            # URI enthält bereits ein ?
            $params["URI"] = $params["URI"] + "&limit=$limit"
        }
        else {
            # URI enthält noch kein ?
            $params["URI"] = $params["URI"] + "?limit=$limit"
        }
    }
    if ($offset) {
        if ($params["URI"] -like "*?*") {
            # URI enthält bereits ein ?
            $params["URI"] = $params["URI"] + "&offset=$offset"
        }
        else {
            # URI enthält noch kein ?
            $params["URI"] = $params["URI"] + "?offset=$offset"
        }
    }

    $Account = Invoke-BrevoCall @params
    return $Account
}