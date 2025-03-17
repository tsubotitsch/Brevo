
function Get-ContactAttribute {
    <#
    .SYNOPSIS
    Retrieves contact attributes from the Brevo API.

    .DESCRIPTION
    The Get-ContactAttribute function sends a GET request to the Brevo API to retrieve contact attributes. 
    It uses the Invoke-BrevoCall function to make the API call and returns the attributes.

    .PARAMS
    None

    .EXAMPLE
    PS C:\> Get-ContactAttribute
    This command retrieves and returns the contact attributes from the Brevo API.

    .Outputs
    The function returns the contact attributes as an array of objects.
    #>
    [CmdletBinding()]
    param (
    )
    $method = "GET"
    $uri = "/contacts/attributes"
    $Params = @{
        "URI"          = $uri
        "Method"       = $method
        "returnobject" = "attributes"
    }
    $attributes = Invoke-BrevoCall @Params
    return $attributes
}