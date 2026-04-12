function New-BrevoCrmAttribute
{
    <#
    .SYNOPSIS
        Creates a new CRM attribute for deals or companies in Brevo.

    .DESCRIPTION
        The New-BrevoCrmAttribute cmdlet creates a new custom attribute in Brevo CRM for use with deals or companies.

    .PARAMETER Entity
        The entity type to create the attribute for. Valid values are "deals" and "companies". This parameter is mandatory.

    .PARAMETER Name
        The name of the attribute. This parameter is mandatory.

    .PARAMETER Label
        The display label for the attribute.

    .PARAMETER Type
        The data type of the attribute (e.g., "text", "number", "date").

    .PARAMETER IsRequired
        If $true, this attribute will be required.

    .EXAMPLE
        New-BrevoCrmAttribute -Entity "deals" -Name "custom_field" -Label "Custom Field" -Type "text"

        Creates a new text attribute for deals.

    .LINK
        https://developers.brevo.com/reference/create-an-attribute
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, HelpMessage = "Entity type for which to create the attribute")]
        [ValidateSet("deals", "companies")]
        [string]$Entity,

        [Parameter(Mandatory, HelpMessage = "Attribute name")]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [Parameter()]
        [string]$Label,

        [Parameter()]
        [string]$Type,

        [Parameter()]
        [bool]$IsRequired = $false
    )

    $uri = "/crm/attributes"
    $method = "POST"

    $body = @{
        entity = $Entity
        name   = $Name
    }

    if ($PSBoundParameters.ContainsKey("Label"))
    {
        $body.label = $Label
    }
    if ($PSBoundParameters.ContainsKey("Type"))
    {
        $body.type = $Type
    }
    if ($PSBoundParameters.ContainsKey("IsRequired"))
    {
        $body.isRequired = $IsRequired
    }

    $Params = @{
        "URI"    = $uri
        "Method" = $method
        "Body"   = $body
    }

    Invoke-BrevoCall @Params
}
