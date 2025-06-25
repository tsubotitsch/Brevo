function Get-BrevoAccount {
    <#
    .SYNOPSIS
    Get your account information, plan and credits details

    .DESCRIPTION
    The `Get-BrevoAccount` function sends a GET request to the Brevo API to retrieve account details. 
    It uses the `Invoke-BrevoCall` function to perform the API call.

    .PARAMETERS
    This function does not take any parameters.

    .OUTPUTS
    Returns the account information as an object.

    .EXAMPLE
    PS> Get-BrevoAccount
    Retrieves the account details from the Brevo API and displays them.
    #>
    [CmdletBinding()]
    param ()
    
    $params = @{
        "URI"    = "/account"
        "Method" = "GET"
    } 

    $Account = Invoke-BrevoCall @params
    return $Account
}