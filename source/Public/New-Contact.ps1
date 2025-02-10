function New-Contact {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "The email address of the contact")]
        [string]$Email,
        [Parameter(Mandatory = $false, HelpMessage = "Pass your own Id to create a contact.")]
        [string]$ext_id,

        [Parameter(Mandatory = $true, HelpMessage = "The ID of the contact list to which the contact is added")]
        [int[]]$ListId,
        [Parameter(Mandatory = $true, HelpMessage = 'Pass the set of attributes and their values. The attribute's parameter should be passed in capital letter while creating a contact. Values that don't match the attribute type (e.g. text or string in a date attribute) will be ignored. These attributes must be present in your Brevo account. For e.g. -Attributes @{"FIRSTNAME"="John"; "LASTNAME"="Doe"}')]
        #TODO: How to provide the attriutes?
        # docu: {"FNAME":"Elly", "LNAME":"Roger", "COUNTRIES":["India","China"]}
        $attributes
    )
    $uri = "/contacts"
    $method = "POST"
    
    $body = @{
        listId = $ListId
        email = $Email
    }
    if ($ext_id) {
        $body.ext_id = $ext_id
    }
    $attributes | ForEach-Object {
        $body.Add($_.Key, $_.Value)
    }

    $Params = @{
        "URI"    = $uri
        "Method" = $method
        "Body"   = $body
    }
    $contact = Invoke-BrevoCall @Params
    return $contact
}