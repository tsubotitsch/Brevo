
function Get-User {
    <#
    .SYNOPSIS
    Retrieves the user information from the Brevo API.

    .DESCRIPTION
    The Get-User function sends a GET request to the Brevo API to retrieve information about invited users in the organization.

    .PARAMS
    None

    .OUTPUTS
    Returns the user information retrieved from the Brevo API.

    .EXAMPLE
    PS> Get-User
    This example retrieves the user information from the Brevo API.
    #>
    $method = "GET"
    $uri = "/user"
    $params = @{   
        "URI"    = "/organization/invited/users"
        "Method" = "GET"    
    }
    $user = Invoke-BrevoCall @params
    return $user
}