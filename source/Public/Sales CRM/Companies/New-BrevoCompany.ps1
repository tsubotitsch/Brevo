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
        The email address associated with the company (stored as the 'email' attribute).

    .PARAMETER Phone
        The phone number of the company (stored as the 'phone_number' attribute).

    .PARAMETER Website
        The website URL of the company (stored as the 'website' attribute).

    .PARAMETER Address
        The address of the company (stored as the 'address' attribute).

    .PARAMETER City
        The city where the company is located (stored as the 'city' attribute).

    .PARAMETER State
        The state/province of the company (stored as the 'state' attribute).

    .PARAMETER ZipCode
        The postal code of the company (stored as the 'zip_code' attribute).

    .PARAMETER Country
        The country of the company (stored as the 'country' attribute).

    .PARAMETER Industry
        The industry of the company (stored as the 'industry' attribute).

    .PARAMETER NumberOfEmployees
        The number of employees in the company (stored as the 'number_of_employees' attribute).

    .PARAMETER Revenue
        The annual revenue of the company (stored as the 'annual_revenue' attribute).

    .PARAMETER LinkedContactIds
        An array of contact IDs to link to the company at creation time.

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

    $body = @{
        name = $Name
    }

    $attributes = @{}

    if ($PSBoundParameters.ContainsKey("Email"))
    {
        $attributes.email = $Email
    }
    if ($PSBoundParameters.ContainsKey("Phone"))
    {
        $attributes.phone_number = $Phone
    }
    if ($PSBoundParameters.ContainsKey("Website"))
    {
        $attributes.website = $Website
    }
    if ($PSBoundParameters.ContainsKey("Address"))
    {
        $attributes.address = $Address
    }
    if ($PSBoundParameters.ContainsKey("City"))
    {
        $attributes.city = $City
    }
    if ($PSBoundParameters.ContainsKey("State"))
    {
        $attributes.state = $State
    }
    if ($PSBoundParameters.ContainsKey("ZipCode"))
    {
        $attributes.zip_code = $ZipCode
    }
    if ($PSBoundParameters.ContainsKey("Country"))
    {
        $attributes.country = $Country
    }
    if ($PSBoundParameters.ContainsKey("Industry"))
    {
        $attributes.industry = $Industry
    }
    if ($PSBoundParameters.ContainsKey("NumberOfEmployees"))
    {
        $attributes.number_of_employees = $NumberOfEmployees
    }
    if ($PSBoundParameters.ContainsKey("Revenue"))
    {
        $attributes.annual_revenue = $Revenue
    }

    if ($attributes.Count -gt 0)
    {
        $body.attributes = $attributes
    }

    if ($PSBoundParameters.ContainsKey("LinkedContactIds"))
    {
        $body.linkedContactsIds = $LinkedContactIds
    }

    $Params = @{
        "URI"    = $uri
        "Method" = "POST"
        "Body"   = $body
    }

    Invoke-BrevoCall @Params
}
