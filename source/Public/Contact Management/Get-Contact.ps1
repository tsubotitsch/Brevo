function Get-Contact {
    <#
    .SYNOPSIS
        Retrieves contact information based on the provided ID.
    
    .DESCRIPTION
        The Get-Contact function retrieves contact information from the Brevo API. 
        It can fetch details using an email ID, phone ID, or contact ID. Optionally, 
        it can also retrieve statistics for specific campaigns within a date range.
    
    .PARAMETER Id
        The ID of the contact. This can be an email ID (for EMAIL), phone ID (for SMS), 
        or contact ID (for the contact).
    
    .PARAMETER startDate
        The starting date (YYYY-MM-DD) of the statistic events specific to campaigns. 
        This parameter is mandatory if endDate is used and must be less than or equal to endDate.
    
    .PARAMETER endDate
        The ending date (YYYY-MM-DD) of the statistic events specific to campaigns. 
        This parameter is mandatory if startDate is used and must be greater than or equal to startDate.
    
    .EXAMPLE
        PS C:\> Get-Contact -Id "example@example.com"
        Retrieves the contact information for the contact with the email ID "example@example.com".
    
    .EXAMPLE
        PS C:\> Get-Contact -Id "12345" -startDate "2023-01-01" -endDate "2023-01-31"
        Retrieves the contact information and campaign statistics for the contact with ID "12345" 
        between January 1, 2023, and January 31, 2023.
    
    .Outputs
        The function returns the contact information as an object.
    #>
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