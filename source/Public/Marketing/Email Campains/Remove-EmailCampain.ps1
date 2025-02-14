function Remove-EmailCampain {
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