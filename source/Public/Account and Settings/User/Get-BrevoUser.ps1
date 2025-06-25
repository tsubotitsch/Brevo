function Get-BrevoUser {
    <#
    .SYNOPSIS
    Retrieves the user information from the Brevo API.

    .DESCRIPTION
    The Get-BrevoUser function sends a GET request to the Brevo API to retrieve information about invited users in the organization.

    .PARAMS
    None

    .OUTPUTS
    Returns the user information retrieved from the Brevo API.

    .EXAMPLE
    PS> Get-BrevoUser
    This example retrieves the user information from the Brevo API.
    #>
    $method = "GET"
    $uri = "/user"
    $params = @{   
        "URI"    = "/organization/invited/users"
        "Method" = "GET"
        "returnobject" = "users"
    }
    $user = Invoke-BrevoCall @params
    return $user
}