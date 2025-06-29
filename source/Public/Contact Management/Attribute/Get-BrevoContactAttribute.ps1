function Get-BrevoContactAttribute {
    <#
    .SYNOPSIS
    Retrieves contact attributes from the Brevo API.

    .DESCRIPTION
    The Get-BrevoContactAttribute function retrieves contact attributes from the Brevo API. 
    It allows filtering by attribute name(s) if specified. The function uses the 
    Invoke-BrevoCall helper function to make the API call.

    .PARAMETER Name
    The name of the contact attribute(s) to filter by. This parameter is case-insensitive 
    and can accept a single string or an array of strings. If not specified, all attributes 
    are returned.

    .EXAMPLE
    # Retrieve all contact attributes
    Get-BrevoContactAttribute

    .EXAMPLE
    Get-BrevoContactAttribute -Name "FirstName"

    Retrieve a specific contact attribute by name

    .EXAMPLE
    Get-BrevoContactAttribute -Name @("FirstName", "LastName")
    # or
    Get-BrevoContactAttribute -Name "FirstName", "LastName"
    
    # Retrieve multiple contact attributes by names
    #>
    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, HelpMessage = "The name of the contact attribute(s) (case-insensitive)")]
        [string[]]$Name
    )
    $method = "GET"
    $uri = "/contacts/attributes"
    $Params = @{
        "URI"          = $uri
        "Method"       = $method
        "returnobject" = "attributes"
    }
    $attribute = Invoke-BrevoCall @Params
    if ((-not [string]::IsNullOrEmpty($name)) -and ($Name -is [String])) {
        $attribute = $attribute | Where-Object { $_.name -ieq $Name }
    }
    if ($Name -is [Array]) {
        $attribute = $attribute | Where-Object { $Name -contains $_.name }
    }

    return $attribute
}
