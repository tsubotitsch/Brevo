function Remove-BrevoContact {
    <#
    .SYNOPSIS
    Removes a contact from the system using the specified identifier.

    .DESCRIPTION
    The Remove-BrevoContact function deletes a contact from the system based on the provided identifier. 
    The identifier can be an email_id (for EMAIL), phone_id (for SMS), or contact_id (for the ID of the contact).

    .PARAMETER Identifier
    The identifier of the contact to be removed. This can be an email_id, phone_id, or contact_id.

    .EXAMPLE
    Remove-BrevoContact -Identifier "contact_id_12345"
    This command removes the contact with the ID "contact_id_12345".

    .EXAMPLE
    Remove-BrevoContact -Identifier "email@example.com"
    This command removes the contact with the email "email@example.com".

    .NOTES
    This function supports ShouldProcess for safety, and has a high confirm impact.
    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "Identifier is email_id (for EMAIL), phone_id (for SMS) or contact_id (for ID of the contact)", Position = 0, ValueFromPipelineByPropertyName = $true )]
        [Alias ("Id")]
        [string]$Identifier
    )
    $uri = "/contacts/$Identifier"
    $method = "DELETE"
    $Params = @{
        "URI"    = $uri
        "Method" = $method        
    }
    if ($PSCmdlet.ShouldProcess("$Identifier", "Remove-BrevoContact")) {
        $contact = Invoke-BrevoCall @Params
        return $contact 
    }
}