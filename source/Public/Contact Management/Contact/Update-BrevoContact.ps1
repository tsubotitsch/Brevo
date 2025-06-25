function Update-BrevoContact {
    <#
    .SYNOPSIS
    Updates a contact in Brevo.

    .DESCRIPTION
    This function updates a contact in Brevo using the provided identifier and optional parameters. 
    It supports updating email and SMS blacklisting status, adding and removing contact from lists, 
    and updating contact attributes.

    .PARAMETER Identifier
    The identifier of the contact. It can be email_id (for EMAIL), phone_id (for SMS), or contact_id (for ID of the contact). This parameter is mandatory.

    .PARAMETER ext_id
    Optional. Pass your own Id to create a contact.

    .PARAMETER emailBlacklisted
    Optional. Set/unset this field to blacklist/allow the contact for emails.

    .PARAMETER smsBlacklisted
    Optional. Set/unset this field to blacklist/allow the contact for SMS.

    .PARAMETER ListIds
    Optional. The IDs of the contact list to which the contact is added.

    .PARAMETER unlinkListIds
    Optional. Ids of the lists to remove the contact from.

    .PARAMETER attributes
    Optional. Pass the set of attributes and their values. The attributes parameter should be passed in capital letters while creating a contact. Values that don't match the attribute type (e.g., text or string in a date attribute) will be ignored. These attributes must be present in your Brevo account. For example: -Attributes @{"FIRSTNAME"="John"; "LASTNAME"="Doe"}

    .EXAMPLE
    PS> Update-BrevoContact -Identifier "contact_id" -emailBlacklisted $true -ListIds @(1,2,3) -attributes @{"FIRSTNAME"="John"; "LASTNAME"="Doe"}

    This command updates the contact with the specified identifier, sets the email blacklisting status to true, adds the contact to lists with IDs 1, 2, and 3, and updates the contact's first name and last name.

    .OUTPUTS
    The function returns the updated contact object.
    
    .LINK
    https://developers.brevo.com/reference/updatecontact
    https://developers.brevo.com/reference/updatebatchcontacts
    #>
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