function New-ContactFolder {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "The name of the contact folder")]
        [string]$Name
    )
    $uri = "/contacts/folders"
    $method = "POST"
    $body = @{
        name = $Name
    }
    $Params = @{
        "URI"    = $uri
        "Method" = $method
        "Body"   = $body
    }
    $folder = Invoke-BrevoCall @Params
    return $folder
}