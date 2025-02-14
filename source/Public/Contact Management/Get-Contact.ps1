function Get-Contact {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, HelpMessage = "ID is email_id (for EMAIL), phone_id (for SMS) or contact_id (for ID of the contact)")]
        [string]$Id,
        [Parameter(Mandatory = $false, HelpMessage = "Mandatory if endDate is used. Starting date (YYYY-MM-DD) of the statistic events specific to campaigns. Must be lower than equal to endDate")]
        [string]$startDate,
        [Parameter(Mandatory = $false, HelpMessage = "Mandatory if startDate is used. Ending date (YYYY-MM-DD) of the statistic events specific to campaigns. Must be greater than equal to startDate.")]
        [string]$endDate
    )
    $uri = "/contacts/$Id"
    $method = "GET"
    $Params = @{
        "URI"          = $uri
        "Method"       = $method
        "returnobject" = "contacts"
    }
    $contact = Invoke-BrevoCall @Params
    return $contact
}