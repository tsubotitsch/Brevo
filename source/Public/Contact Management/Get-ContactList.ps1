function Get-ContactList {
    [CmdletBinding()]
    param (
        #TODO  limit, offset, sort
    )
    $list = Invoke-BrevoCall -uri "/contacts/lists"
    return $list

    $uri = "/contacts/lists"
    $method = "GET"
    $params = @{
        "URI"    = $uri
        "Method" = $method
        "returnobject" = "lists"
    }

    $list = Invoke-BrevoCall @params
    return $list
}