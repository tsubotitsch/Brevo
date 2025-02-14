function Get-UserPermission {
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