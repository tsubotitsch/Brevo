function Remove-BrevoEmailCampaign {
    <#
    .SYNOPSIS
    Removes an email campaign by its ID.

    .DESCRIPTION
    The Remove-BrevoEmailCampaign function deletes an email campaign specified by the campaign ID. 
    It sends a DELETE request to the Brevo API to remove the campaign.

    .PARAMETER campaignId
    The ID of the campaign to be deleted. This parameter is mandatory.

    .EXAMPLE
    Remove-BrevoEmailCampaign -campaignId "12345"
    This command deletes the email campaign with the ID "12345".

    .EXAMPLE
    "12345" | Remove-BrevoEmailCampaign

    This command deletes the email campaign with the ID "12345" by passing the ID through the pipeline.

    .OUTPUTS
    
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    param(
        [Parameter(Mandatory = $true, HelpMessage = "ID of the campaign to be deleted", ValueFromPipelineByPropertyName = $true)]
        [Alias("Id")]
        [string]$campaignId

    )
    process {
        $uri = "/emailCampaigns/$campaignId"
        $Params = @{
            "URI"    = $uri
            "Method" = "DELETE"
        }
        if ($PSCmdlet.ShouldProcess("$campaignId", "Remove-BrevoEmailCampaign")) {
            $emailCampaign = Invoke-BrevoCall @Params
            return $emailCampaign
        }
    }
}
