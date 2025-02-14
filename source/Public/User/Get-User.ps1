function Get-User {
    $method = "GET"
    $uri = "/user"
    $params = @{   
        "URI"    = "/organization/invited/users"
        "Method" = "GET"    
    }
    $user = Invoke-BrevoCall @params
    return $user
}