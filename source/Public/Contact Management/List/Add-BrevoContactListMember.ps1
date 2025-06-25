function Add-BrevoContactListMember {
    <#
    .SYNOPSIS
    Adds members to a specified contact list in Brevo.

    .DESCRIPTION
    The Add-BrevoContactListMember function allows you to add contacts to a specific contact list in Brevo. 
    You can add contacts using their email addresses, IDs, or external IDs (EXTID attributes). 
    The function supports adding up to 150 contacts in a single request.

    .PARAMETER listId
    The ID of the contact list to update. This parameter is mandatory.

    .PARAMETER emails
    An array of email addresses to add to the contact list. 
    This parameter is mandatory when using the "AddContactToListByEmails" parameter set. 
    You can pass a maximum of 150 email addresses in one request.

    .PARAMETER ids
    An array of contact IDs to add to the contact list. 
    This parameter is optional and used with the "AddContactToListByIds" parameter set. 
    You can pass a maximum of 150 IDs in one request.

    .PARAMETER extids
    An array of external IDs (EXTID attributes) to add to the contact list. 
    This parameter is optional and used with the "AddContactToListByExtIds" parameter set. 
    You can pass a maximum of 150 EXTID attributes in one request.

    .OUTPUTS
    Object
    Returns the updated (success/failure) contact list object.

    .EXAMPLE
    # Example 1: Add contacts to a list using email addresses
    Add-BrevoContactListMember -listId 123 -emails @("example1@example.com", "example2@example.com")

    # Example 2: Add contacts to a list using contact IDs
    Add-BrevoContactListMember -listId 123 -ids @(101, 102, 103)

    # Example 3: Add contacts to a list using external IDs
    Add-BrevoContactListMember -listId 123 -extids @(201, 202, 203)

    .NOTES
    - Ensure that you provide at least one of the parameters: emails, ids, or extids.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "The ID of the contact list to update")]
        [int]$listId,
        [Parameter(Mandatory = $true, HelpMessage = "array of strings. Length between 1 and 150. Emails to add to a list. You can pass a maximum of 150 emails for addition in one request.", ParameterSetName = "AddContactToListByEmails")]
        [string[]]$emails,
        [Parameter(Mandatory = $false, HelpMessage = "IDs to add to a list. You can pass a maximum of 150 IDs for addition in one request.", ParameterSetName = "AddContactToListByIds")]
        [int[]]$ids,
        [Parameter(Mandatory = $false, HelpMessage = "EXTID attributes to add to a list. You can pass a maximum of 150 EXT_ID attributes for addition in one request.", ParameterSetName = "AddContactToListByExtIds")]
        [int[]]$extids
    )
    $uri = "/contacts/lists/$listId/contacts/add"
    $method = "POST"

    $body = @{}
    if ($emails) {
        $body = @{
            emails = $emails
        }
    } elseif ($ids) {
        $body = @{
            ids = $ids
        }
    } elseif ($extids) {
        $body = @{
            extIds = $extids
        }
    } else {
        Write-Error "Please provide either emails, ids or extids."
        return
    }
    
    $Params = @{
        "URI"    = $uri
        "Method" = $method
        "Body"   = $body
        "returnobject" = "contacts"
    }


    $list = Invoke-BrevoCall @Params
    return $list
}