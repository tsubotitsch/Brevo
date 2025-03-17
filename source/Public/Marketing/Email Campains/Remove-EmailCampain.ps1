
function Remove-EmailCampain {
    <#
    .SYNOPSIS
    Removes an email campaign by its ID.

    .DESCRIPTION
    The Remove-EmailCampain function deletes an email campaign specified by the campaign ID. 
    It sends a DELETE request to the Brevo API to remove the campaign.

    .PARAMETER campaignId
    The ID of the campaign to be deleted. This parameter is mandatory.

    .EXAMPLE
    Remove-EmailCampain -campaignId "12345"
    This command deletes the email campaign with the ID "12345".

    .OUTPUTS
    
    #>
    [CmdletBinding()]   
    param(
        [Parameter(Mandatory = $true, HelpMessage = "ID of the campaign to be deleted")]
        [string]$campaignId

        #TODO
    )
    $uri = "/emailCampaigns/$id"   
    $Params = @{
        "URI"    = $uri
        "Method" = "DELETE"
    }
    $emailCampain = Invoke-BrevoCall @Params
    return $emailCampain
}