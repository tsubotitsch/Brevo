function Update-BrevoCompany
{
    <#
    .SYNOPSIS
        Updates an existing company in Brevo CRM.

    .DESCRIPTION
        Updates the properties of a company identified by its ID.

    .PARAMETER Id
        The unique ID of the company to update. This parameter is mandatory.

    .PARAMETER Name
        The updated name of the company.

    .PARAMETER Email
        The updated email address of the company (stored as the 'email' attribute).

    .PARAMETER Phone
        The updated phone number of the company (stored as the 'phone_number' attribute).

    .PARAMETER Website
        The updated website URL of the company (stored as the 'website' attribute).

    .PARAMETER Address
        The updated address of the company (stored as the 'address' attribute).

    .PARAMETER City
        The updated city of the company (stored as the 'city' attribute).

    .PARAMETER State
        The updated state/province of the company (stored as the 'state' attribute).

    .PARAMETER ZipCode
        The updated postal code of the company (stored as the 'zip_code' attribute).

    .PARAMETER Country
        The updated country of the company (stored as the 'country' attribute).

    .PARAMETER Industry
        The updated industry of the company (stored as the 'industry' attribute).

    .PARAMETER NumberOfEmployees
        The updated number of employees (stored as the 'number_of_employees' attribute).

    .PARAMETER Revenue
        The updated annual revenue (stored as the 'annual_revenue' attribute).

    .EXAMPLE
        Update-BrevoCompany -Id "123456" -Name "Acme Corp Updated" -Phone "+1-555-0200"

        Updates the name and phone number of a company.

    .LINK
        https://developers.brevo.com/reference/update-company
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [Alias("CompanyId")]
        [string]$Id,

        [Parameter()]
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
        [decimal]$Revenue
    )

    $uri = "/companies/$Id"

    $body = @{}
    $attributes = @{}

    if ($PSBoundParameters.ContainsKey("Name"))
    {
        $body.name = $Name
    }
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

    $Params = @{
        "URI"    = $uri
        "Method" = "PATCH"
        "Body"   = $body
    }

    Invoke-BrevoCall @Params
}
