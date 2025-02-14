function Send-EmailCampain {
    [CmdletBinding()]   
    param(
        [Parameter(Mandatory = $true, HelpMessage = "ID of the campaign to be sent")]
        [string]$campaignId
    )
    $uri = "https://api.sendinblue.com/v3/emailCampaigns/$campaignId/sendNow"   
    $Params = @{
        "URI"    = $uri
        "Method" = "POST"
    }
    $emailCampain = Invoke-BrevoCall @Params
    return $emailCampain
}