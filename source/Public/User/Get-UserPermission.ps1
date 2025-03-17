
function Get-UserPermission {
    <#
    .SYNOPSIS
    Retrieves the permissions of a user based on their email.

    .DESCRIPTION
    The Get-UserPermission function sends a GET request to retrieve the permissions of a user identified by their email address. It uses the Invoke-BrevoCall function to make the API call and returns the user's permissions.

    .PARAMETER email
    The email address of the invited user whose permissions are to be retrieved. This parameter is mandatory.

    .EXAMPLE
    PS> Get-UserPermission -email "user@example.com"
    This command retrieves the permissions for the user with the email "user@example.com".

    .OUTPUTS
    Returns the permissions of the specified user.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, HelpMessage = "Email of the invited user.")]
        [string]$email
    )   
    $method = "GET"
    $uri = "/organization/user/$email/permissions"
    $params = @{   
        "URI"          = $uri
        "Method"       = $method
        "returnobject" = "privileges"
    }
    $userPermission = Invoke-BrevoCall @params
    return $userPermission  
}