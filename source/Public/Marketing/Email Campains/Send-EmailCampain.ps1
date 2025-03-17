
function Send-EmailCampain {
    <#
    .SYNOPSIS
    Sends an email campaign immediately using the Sendinblue API.

    .DESCRIPTION
    The Send-EmailCampain function sends an email campaign specified by the campaign ID immediately using the Sendinblue API. The function constructs the API endpoint URL using the provided campaign ID and makes a POST request to the Sendinblue API to trigger the campaign.

    .PARAMETER campaignId
    The ID of the campaign to be sent. This parameter is mandatory.

    .EXAMPLE
    Send-EmailCampain -campaignId "12345"
    This example sends the email campaign with the ID "12345" immediately.

    .OUTPUTS
    Returns the email campaign object.
    #>
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