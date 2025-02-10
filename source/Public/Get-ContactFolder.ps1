function Get-ContactFolder {
    [CmdletBinding()]
    param ()
    $uri = "/contacts/folders"
    $folder = Invoke-BrevoCall -uri $uri
    return $folder
}