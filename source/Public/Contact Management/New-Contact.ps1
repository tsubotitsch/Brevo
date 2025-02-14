function New-Contact {
    <#
    .SYNOPSIS
    Creates a new contact in Brevo.

    .DESCRIPTION
    The New-Contact function creates a new contact in Brevo with the specified email address, contact list IDs, and optional attributes.

    .PARAMETER Email
    The email address of the contact. This parameter is mandatory.

    .PARAMETER ext_id
    Optional. Pass your own Id to create a contact.

    .PARAMETER ListIds
    Optional. The IDs of the contact lists to which the contact is added.

    .PARAMETER attributes
    Optional. Pass the set of attributes and their values. The attributes parameter should be passed in capital letters while creating a contact. Values that don't match the attribute type (e.g., text or string in a date attribute) will be ignored. These attributes must be present in your Brevo account. For example: -Attributes @{"FIRSTNAME"="John"; "LASTNAME"="Doe"}

    .EXAMPLE
    PS C:\> New-Contact -Email "john.doe@example.com"
    Creates a new contact with the email "john.doe@example.com"

    .EXAMPLE
    PS C:\> New-Contact -Email "john.doe@example.com" -ListIds 123, 456 -Attributes @{"FIRSTNAME"="John"; "LASTNAME"="Doe"}
    Creates a new contact with the email "john.doe@example.com", adds the contact to the lists with IDs 123 and 456, and sets the first name to "John" and the last name to "Doe".

    .OUTPUTS
    The function returns the created contact Id.
    
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "The email address of the contact")]
        [string]$Email,
        [Parameter(Mandatory = $false, HelpMessage = "Pass your own Id to create a contact.")]
        [string]$ext_id,

        [Parameter(Mandatory = $false, HelpMessage = "The IDs of the contact list to which the contact is added")]
        [int[]]$ListIds,
        [Parameter(Mandatory = $false, HelpMessage = 'Pass the set of attributes and their values. The attributes parameter should be passed in capital letter while creating a contact. Values that dont match the attribute type (e.g. text or string in a date attribute) will be ignored. These attributes must be present in your Brevo account. For e.g. -Attributes @{"FIRSTNAME"="John"; "LASTNAME"="Doe"}')]
        #TODO: How to provide the attriutes?
        # docu: {"FNAME":"Elly", "LNAME":"Roger", "COUNTRIES":["India","China"]}
        $attributes
    )
    $uri = "/contacts"
    $method = "POST"
    
    $body = @{
        listIds = $ListIds
        email   = $Email
    }
    if ($ext_id) {
        $body.ext_id = $ext_id
    }
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
        "returnobject" = "contacts"
    }
    $contact = Invoke-BrevoCall @Params
    return $contact
}