function Get-ContactList {
    [CmdletBinding()]
    param (
        #TODO  limit, offset, sort
    )
    $list = Invoke-BrevoCall -uri "/contacts/lists"
    return $list

    $uri = "/contacts/lists"
    $method = "GET"
    $list = Invoke-BrevoCall -uri $uri -method $method
    return $list
}