
function Get-EmailCampaign {
    <#
    .SYNOPSIS
    Retrieves email campaigns based on specified filters.

    .DESCRIPTION
    The Get-EmailCampaign function retrieves email campaigns from the Brevo API based on various optional filters such as type, status, statistics, date range, and more.

    .PARAMETER id
    The ID(s) of the specific campaign to retrieve. If not specified, all campaigns are retrieved.

    .PARAMETER name
    The name(s) of the specific campaign to retrieve. If not specified, all campaigns are retrieved.

    .PARAMETER type
    Filter on the type of the campaigns. Valid values are "classic" and "trigger".

    .PARAMETER status
    Filter on the status of the campaign. Valid values are "suspended", "archive", "sent", "queued", "draft", and "inProgress".

    .PARAMETER statistics
    Filter on the type of statistics required. Valid values are "globalStats", "linkStats", and "statsByDomain". This option only returns data for events occurred in the last 6 months.

    .PARAMETER startDate
    Mandatory if endDate is used. Starting (urlencoded) UTC date-time (YYYY-MM-DDTHH:mm:ss.SSSZ) to filter the sent email campaigns. Prefer to pass your timezone in date-time format for accurate result. Only available if either 'status' is not passed or if passed is set to 'sent'.

    .PARAMETER endDate
    Mandatory if startDate is used. Ending (urlencoded) UTC date-time (YYYY-MM-DDTHH:mm:ss.SSSZ) to filter the sent email campaigns. Prefer to pass your timezone in date-time format for accurate result. Only available if either 'status' is not passed or if passed is set to 'sent'.

    .PARAMETER limit
    Number of documents per page. Defaults to 50. Valid range is 0 to 100.

    .PARAMETER offset
    Index of the first document in the page. Defaults to 0.

    .PARAMETER sort
    Sort the results in the ascending/descending order of record creation. Default order is descending if sort is not passed.

    .PARAMETER excludeHtmlContent
    Use this flag to exclude htmlContent from the response body. If set to true, htmlContent field will be returned as an empty string in the response body.

    .EXAMPLE
    Get-EmailCampaign -type "classic" -status "sent" -startDate "2023-01-01T00:00:00.000Z" -endDate "2023-01-31T23:59:59.999Z"

    .EXAMPLE
    Get-EmailCampaign -statistics "globalStats" -limit 10 -offset 0 -sort "asc"

    .OUTPUTS
    Returns the email campaigns that match the specified filters.
    #>
    [CmdletBinding()]   
    param(
        [Parameter(Mandatory = $false, HelpMessage = "The Id(s) of the campaign")]
        [int[]]$id,
        [Parameter(Mandatory = $false, HelpMessage = "The name(s) of the campaign")]
        [string[]]$name,
        [Parameter(Mandatory = $false, HelpMessage = "Filter on the type of the campaigns")]
        [ValidateSet("classic", "trigger")]
        [string]$type,
        [Parameter(Mandatory = $false, HelpMessage = "Filter on the status of the campaign")]
        [ValidateSet("suspended", "archive", "sent", "queued", "draft", "inProgress")]
        [string]$status,
        [Parameter(Mandatory = $false, HelpMessage = "Filter on the type of statistics required. Example globalStats value will only fetch globalStats info of the campaign in returned response.This option only returns data for events occurred in the last 6 months.For older campaigns, it’s advisable to use the Get Campaign Report endpoint.")]
        [ValidateSet("globalStats", "linkStats", "statsByDomain")]  
        [string]$statistics,
        [Parameter(Mandatory = $false, HelpMessage = "Mandatory if endDate is used. Starting (urlencoded) UTC date-time (YYYY-MM-DDTHH:mm:ss.SSSZ) to filter the sent email campaigns. Prefer to pass your timezone in date-time format for accurate result ( only available if either 'status' not passed and if passed is set to 'sent' )")] 
        [string]$startDate,
        [Parameter(Mandatory = $false, HelpMessage = "Mandatory if startDate is used. Ending (urlencoded) UTC date-time (YYYY-MM-DDTHH:mm:ss.SSSZ) to filter the sent email campaigns.Prefer to pass your timezone in date-time format for accurate result ( only available if either 'status' not passed and if passed is set to 'sent' )")]
        [string]$endDate,
        [Parameter(Mandatory = $false, HelpMessage = "0 to 100 Defaults to 50. Number of documents per page")]
        [string]$limit,
        [Parameter(Mandatory = $false, HelpMessage = "Defaults to 0 Index of the first document in the page")]   
        [int]$offset,
        [Parameter(Mandatory = $false, HelpMessage = "Defaults to desc Sort the results in the ascending/descending order of record creation. Default order is descending if sort is not passed")]   
        [string]$sort,  
        [Parameter(Mandatory = $false, HelpMessage = "Use this flag to exclude htmlContent from the response body. If set to true, htmlContent field will be returned as empty string in the response body")]
        [bool]$excludeHtmlContent
    )
    $uri = "/emailCampaigns"   

    $body = @{}
    #$value ? $(body.value = $value) : $null
    $type ? ($body.type = $type) : $null
    $status ? ($body.status = $status) : $null
    $statistics ? ($body.statistics = $statistics) : $null
    $startDate ? ($body.startDate = $startDate) : $null
    $endDate ? ($body.endDate = $endDate) : $null
    $limit ? ($body.limit = $limit) : $null
    $offset ? ($body.offset = $offset) : $null
    $sort ? ($body.sort = $sort) : $null
    $excludeHtmlContent ? ($body.excludeHtmlContent = $excludeHtmlContent) : $null

    $Params = @{
        "URI"    = $uri
        "Method" = "GET"
        "Body"   = $body
        # "returnobject" = "campaigns"
    }
    $emailCampaign = Invoke-BrevoCall @Params
    if ($id) {
        $emailCampaign = $emailCampaign | Where-Object { $id -contains $_.id }
    }
    if ($name) {
        $emailCampaign = $emailCampaign | Where-Object { $name -contains $_.name }
    }
    return $emailCampaign
}