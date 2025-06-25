function Disconnect-Brevo {
    <#
    .SYNOPSIS
    Disconnects from the Brevo API by clearing the stored API URI and API key.
    
    .DESCRIPTION
    The `Disconnect-Brevo` function clears the global variables `$script:APIuri` and `$script:APIkey`, effectively disconnecting from the Brevo API. 
    It also provides a confirmation message indicating the disconnection.
    
    .EXAMPLE
    Disconnect-Brevo
    
    This command disconnects the current session from the Brevo API and displays a confirmation message.
    
    .OUTPUTS
    True if the disconnection was successful, otherwise nothing.
    #>

    [CmdletBinding()]
    [OutputType([bool])]
    param()

    $script:APIuri = $null
    $script:APIkey = $null
    Write-Host -ForegroundColor Green "Disconnected from Brevo API"
    return $true
}
