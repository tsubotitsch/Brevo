function Remove-BrevoSender {
    <#
    .SYNOPSIS
    Delete a sender domain in Brevo.
    
    .DESCRIPTION
    The Remove-BrevoSender function sends a DELETE request to the Brevo API to remove a sender domain. 
    It uses the Invoke-BrevoCall function to perform the API call.

    .PARAMETER SenderId
    The ID of the sender domain to be removed.

    .EXAMPLE
    PS> Remove-BrevoSender -SenderId 1234567890
    Removes the sender domain with ID 1234567890 from Brevo.
    
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "The ID of the sender domain to be removed")]
        [string]$SenderId
    )

    $params = @{
        "URI"          = "/senders/$SenderId"
        "Method"       = "DELETE"
    } 

    $Sender = Invoke-BrevoCall @params
    return $Sender
}