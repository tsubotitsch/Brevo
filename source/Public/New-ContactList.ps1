function New-ContactList {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "The name of the contact list")]
        [string]$Name,
        [Parameter(Mandatory = $true, HelpMessage = "The ID of the folder in which the contact list is created")]
        $FolderId
    )
    $uri = "/contacts/lists"
    $method = "POST"
    
    $body = @{
        name = $Name
        folderId = $FolderId
    }
    $Params = @{
        "URI"    = $uri
        "Method" = $method
        "Body"   = $body
    }
    $list = Invoke-BrevoCall @Params
    return $list
}
