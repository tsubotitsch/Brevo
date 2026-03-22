function Update-BrevoNote
{
    <#
    .SYNOPSIS
        Updates an existing note in Brevo CRM.

    .DESCRIPTION
        Updates the content and/or linked entities (companies, contacts, deals) of a
        note identified by its ID. Calls PATCH /v3/crm/notes/:id.
        Returns no content on success (HTTP 204).

    .PARAMETER Id
        The unique ID of the note to update.

    .PARAMETER Text
        The updated text content of the note. Must be between 1 and 3000 characters.

    .PARAMETER CompanyIds
        Optional. List of company IDs to link to the note.

    .PARAMETER ContactIds
        Optional. List of contact IDs (integers) to link to the note.

    .PARAMETER DealIds
        Optional. List of deal IDs to link to the note.

    .EXAMPLE
        Update-BrevoNote -Id "61a5cd07ca1347c82306ad09" -Text "Follow-up scheduled for next week."

    .EXAMPLE
        Update-BrevoNote -Id "61a5cd07ca1347c82306ad09" -Text "Linked to deal and contact." -DealIds @("61a5ce58c5d4795761045990") -ContactIds @(1, 2)

    .LINK
        https://developers.brevo.com/reference/update-a-note
    #>
    [CmdletBinding()]
    param (
        # Note ID to update (path parameter)
        [Parameter(Mandatory)]
        [Alias("NoteId")]
        [string]$Id,

        # Text content of the note (1-3000 characters)
        [Parameter(Mandatory)]
        [ValidateLength(1, 3000)]
        [string]$Text,

        # Company IDs to link to the note
        [Parameter()]
        [string[]]$CompanyIds,

        # Contact IDs to link to the note
        [Parameter()]
        [int[]]$ContactIds,

        # Deal IDs to link to the note
        [Parameter()]
        [string[]]$DealIds
    )

    $uri = "/crm/notes/$Id"

    $body = @{
        text = $Text
    }

    if ($PSBoundParameters.ContainsKey("CompanyIds"))
    {
        $body.companyIds = $CompanyIds 
    }
    if ($PSBoundParameters.ContainsKey("ContactIds"))
    {
        $body.contactIds = $ContactIds 
    }
    if ($PSBoundParameters.ContainsKey("DealIds"))
    {
        $body.dealIds = $DealIds 
    }

    $Params = @{
        "URI"    = $uri
        "Method" = "PATCH"
        "Body"   = $body
    }
    Invoke-BrevoCall @Params
}
