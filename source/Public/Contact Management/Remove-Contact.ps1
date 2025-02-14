function Remove-Contact {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "Identifier is email_id (for EMAIL), phone_id (for SMS) or contact_id (for ID of the contact)", Position = 0 )]
        [Alias ("Id")]
        [string]$Identifier
    )
    $uri = "/contacts/$Identifier"
    $method = "DELETE"
    $Params = @{
        "URI"    = $uri
        "Method" = $method        
    }
    if ($PSCmdlet.ShouldProcess("$script:graphQLApiUrl")) {
        $contact = Invoke-BrevoCall @Params
        return $contact 
    }
}