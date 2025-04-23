
function Remove-EmailCampaign {
    <#
    .SYNOPSIS
    Removes an email campaign by its ID.

    .DESCRIPTION
    The Remove-EmailCampaign function deletes an email campaign specified by the campaign ID. 
    It sends a DELETE request to the Brevo API to remove the campaign.

    .PARAMETER campaignId
    The ID of the campaign to be deleted. This parameter is mandatory.

    .EXAMPLE
    Remove-EmailCampaign -campaignId "12345"
    This command deletes the email campaign with the ID "12345".

    .OUTPUTS
    
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    param(
        [Parameter(Mandatory = $true, HelpMessage = "ID of the campaign to be deleted", ValueFromPipelineByPropertyName = $true)]
        [Alias("Id")]
        [string]$campaignId

        #TODO
    )
    $uri = "/emailCampaigns/$id"   
    $Params = @{
        "URI"    = $uri
        "Method" = "DELETE"
    }
    if ($PSCmdlet.ShouldProcess("$campaignId", "Remove-EmailCampaign")) {
        $emailCampaign = Invoke-BrevoCall @Params
        return $emailCampaign
    }
}