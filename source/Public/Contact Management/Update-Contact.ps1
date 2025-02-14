
function Update-Contact {
    # https://developers.brevo.com/reference/updatecontact
    # https://developers.brevo.com/reference/updatebatchcontacts
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "Identifier is email_id (for EMAIL), phone_id (for SMS) or contact_id (for ID of the contact)")]
        [Alias ("Id")]        
        [string]$Identifier,
        [Parameter(Mandatory = $false, HelpMessage = "Pass your own Id to create a contact.")]
        [string]$ext_id,
        [Parameter(Mandatory = $false, HelpMessage = "Set/unset this field to blacklist/allow the contact for emails")]
        [bool]$emailBlacklisted,
        [Parameter(Mandatory = $false, HelpMessage = "Set/unset this field to blacklist/allow the contact for SMS")]
        [bool]$smsBlacklisted,
        [Parameter(Mandatory = $false, HelpMessage = "The IDs of the contact list to which the contact is added")]
        [int[]]$ListIds,
        [Parameter(Mandatory = $false, HelpMessage = "Ids of the lists to remove the contact from")]
        [int[]]$unlinkListIds,
        [Parameter(Mandatory = $false, HelpMessage = 'Pass the set of attributes and their values. The attributes parameter should be passed in capital letter while creating a contact. Values that dont match the attribute type (e.g. text or string in a date attribute) will )
        be ignored. These attributes must be present in your Brevo account. For e.g. -Attributes @{"FIRSTNAME"="John"; "LASTNAME"="Doe"}')]
        $attributes
    )
    $uri = "/contacts/$Identifier"
    $method = "PATCH"
    $body = @{}
    #$isRecurring ? ($body.isRecurring = $isRecurring) : $null
    $ext_id ? ($body.ext_id = $ext_id) : $null
    $emailBlacklisted ? ($body.emailBlacklisted = $emailBlacklisted) : $null
    $smsBlacklisted ? ($body.smsBlacklisted = $smsBlacklisted) : $null
    $ListIds ? ($body.listIds = $ListIds) : $null
    $unlinkListIds ? ($body.unlinkListIds = $unlinkListIds) : $null

    if ($attributes) {
        $attrib = @{}
        $attributes | ForEach-Object {
            $attrib.Add($_.Key, $_.Value)
        }
        $body.attributes = $attrib
    }

    $Params = @{
        "URI"    = $uri
        "Method" = $method
        "Body"   = $body
    }
    $contact = Invoke-BrevoCall @Params
    return $contact
}   