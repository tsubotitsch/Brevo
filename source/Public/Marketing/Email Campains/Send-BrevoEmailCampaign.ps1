function Send-BrevoEmailCampaign {
    <#
    .SYNOPSIS
    Sends an email campaign immediately using the Sendinblue API.

    .DESCRIPTION
    The Send-BrevoEmailCampaign function sends an email campaign specified by the campaign ID immediately using the Sendinblue API. The function constructs the API endpoint URL using the provided campaign ID and makes a POST request to the Sendinblue API to trigger the campaign.

    .PARAMETER campaignId
    The ID of the campaign to be sent. This parameter is mandatory.

    .EXAMPLE
    Send-BrevoEmailCampaign -campaignId "12345"
    
    This example sends the email campaign with the ID "12345" immediately.

    .EXAMPLE
    "12345" | Send-BrevoEmailCampaign

    .OUTPUTS
    Returns the email campaign object.
    
    #>
    [CmdletBinding()]   
    param(
        [Parameter(Mandatory = $true, HelpMessage = "ID of the campaign to be sent", ValueFromPipelineByPropertyName = $true, ValueFromPipeline = $true)]
        [string]$campaignId
    )
    process{
        $uri = "https://api.sendinblue.com/v3/emailCampaigns/$campaignId/sendNow"   
        $Params = @{
            "URI"    = $uri
            "Method" = "POST"
        }
        $emailCampaign = Invoke-BrevoCall @Params
        return $emailCampaign
    }
}
