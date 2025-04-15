function Get-ContactFolder {
    <#
    .SYNOPSIS
    Retrieves a list of contact folders.

    .DESCRIPTION
    The Get-ContactFolder function sends a GET request to the /contacts/folders endpoint to retrieve a list of contact folders. 

    .PARAMS
    None

    .OUTPUTS
    Returns an array of contact folders.

    .EXAMPLE
    PS> Get-ContactFolder
    This example retrieves and displays the list of contact folders.

    #>
    [CmdletBinding()]
    param ()
    $method = "GET"
    $uri = "/contacts/folders"
    #$returnobject = "folders"

    $Params = @{
        "URI"          = $uri
        "Method"       = $method
        # "returnobject" = $returnobject
    }
    
    $folder = Invoke-BrevoCall @Params
    return $folder
}