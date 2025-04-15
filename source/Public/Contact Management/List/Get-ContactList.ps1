function Get-ContactList {
    <#
    .SYNOPSIS
        Retrieves contact lists.

    .DESCRIPTION
        The Get-ContactList function calls the Brevo API to retrieve contact lists.

    .PARAMETER None
        This function does not take any parameters.

    .EXAMPLE
        PS C:\> Get-ContactList
        Retrieves contacts list from the Brevo API.

    .OUTPUTS
        Returns an array of contact lists.
    #>
    [CmdletBinding()]
    param (
        #TODO  limit, offset, sort
    )
    $list = Invoke-BrevoCall -uri "/contacts/lists"
    return $list

    $uri = "/contacts/lists"
    $method = "GET"
    $params = @{
        "URI"          = $uri
        "Method"       = $method
        "returnobject" = "lists"
    }

    $list = Invoke-BrevoCall @params
    return $list
}