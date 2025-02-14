function Get-EmailCampain {
    [CmdletBinding()]   
    param(
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
        "URI"          = $uri
        "Method"       = "GET"
        "Body"         = $body
        "returnobject" = "campaigns"
    }
    $emailCampain = Invoke-BrevoCall @Params
    return $emailCampain
}