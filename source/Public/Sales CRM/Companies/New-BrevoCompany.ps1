function New-BrevoCompany
{
    <#
    .SYNOPSIS
        Creates a new company in Brevo CRM.

    .DESCRIPTION
        The New-BrevoCompany cmdlet creates a new company in Brevo CRM.

    .PARAMETER Name
        The name of the company. This parameter is mandatory.

    .PARAMETER Email
        The email address associated with the company.

    .PARAMETER Phone
        The phone number of the company.

    .PARAMETER Website
        The website URL of the company.

    .PARAMETER Address
        The address of the company.

    .PARAMETER City
        The city where the company is located.

    .PARAMETER State
        The state/province of the company.

    .PARAMETER ZipCode
        The postal code of the company.

    .PARAMETER Country
        The country of the company.

    .PARAMETER Industry
        The industry of the company.

    .PARAMETER NumberOfEmployees
        The number of employees in the company.

    .PARAMETER Revenue
        The annual revenue of the company.

    .PARAMETER LinkedContactIds
        An array of contact IDs to link to the company.

    .EXAMPLE
        New-BrevoCompany -Name "Acme Corp" -Email "info@acme.com" -Phone "+1-555-0100" -Website "https://acme.com"

        Creates a new company with basic information.

    .LINK
        https://developers.brevo.com/reference/create-company
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, HelpMessage = "Company name")]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [Parameter()]
        [string]$Email,

        [Parameter()]
        [string]$Phone,

        [Parameter()]
        [string]$Website,

        [Parameter()]
        [string]$Address,

        [Parameter()]
        [string]$City,

        [Parameter()]
        [string]$State,

        [Parameter()]
        [string]$ZipCode,

        [Parameter()]
        [string]$Country,

        [Parameter()]
        [string]$Industry,

        [Parameter()]
        [int]$NumberOfEmployees,

        [Parameter()]
        [decimal]$Revenue,

        [Parameter()]
        [int[]]$LinkedContactIds
    )

    $uri = "/companies"
    $method = "POST"

    $body = @{
        name = $Name
    }

    if ($PSBoundParameters.ContainsKey("Email"))
    {
        $body.email = $Email
    }
    if ($PSBoundParameters.ContainsKey("Phone"))
    {
        $body.phone = $Phone
    }
    if ($PSBoundParameters.ContainsKey("Website"))
    {
        $body.website = $Website
    }
    if ($PSBoundParameters.ContainsKey("Address"))
    {
        $body.address = $Address
    }
    if ($PSBoundParameters.ContainsKey("City"))
    {
        $body.city = $City
    }
    if ($PSBoundParameters.ContainsKey("State"))
    {
        $body.state = $State
    }
    if ($PSBoundParameters.ContainsKey("ZipCode"))
    {
        $body.zipCode = $ZipCode
    }
    if ($PSBoundParameters.ContainsKey("Country"))
    {
        $body.country = $Country
    }
    if ($PSBoundParameters.ContainsKey("Industry"))
    {
        $body.industry = $Industry
    }
    if ($PSBoundParameters.ContainsKey("NumberOfEmployees"))
    {
        $body.numberOfEmployees = $NumberOfEmployees
    }
    if ($PSBoundParameters.ContainsKey("Revenue"))
    {
        $body.revenue = $Revenue
    }
    if ($PSBoundParameters.ContainsKey("LinkedContactIds"))
    {
        $body.linkedContactIds = $LinkedContactIds
    }

    $Params = @{
        "URI"    = $uri
        "Method" = $method
        "Body"   = $body
    }

    Invoke-BrevoCall @Params
}
