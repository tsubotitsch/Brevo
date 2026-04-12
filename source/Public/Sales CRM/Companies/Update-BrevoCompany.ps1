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
        The updated email address of the company.

    .PARAMETER Phone
        The updated phone number of the company.

    .PARAMETER Website
        The updated website URL of the company.

    .PARAMETER Address
        The updated address of the company.

    .PARAMETER City
        The updated city of the company.

    .PARAMETER State
        The updated state/province of the company.

    .PARAMETER ZipCode
        The updated postal code of the company.

    .PARAMETER Country
        The updated country of the company.

    .PARAMETER Industry
        The updated industry of the company.

    .PARAMETER NumberOfEmployees
        The updated number of employees.

    .PARAMETER Revenue
        The updated annual revenue.

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

    if ($PSBoundParameters.ContainsKey("Name"))
    {
        $body.name = $Name
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

    $Params = @{
        "URI"    = $uri
        "Method" = "PATCH"
        "Body"   = $body
    }

    Invoke-BrevoCall @Params
}
