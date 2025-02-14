function Get-ContactAttribute {
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