function Get-ContactFolder {
    [CmdletBinding()]
    param ()
    $method = "GET"
    $uri = "/contacts/folders"
    $returnobject = "folders"

    $Params = @{
        "URI"          = $uri
        "Method"       = $method
        "returnobject" = $returnobject
    }
    
    $folder = Invoke-BrevoCall @Params
    return $folder
}