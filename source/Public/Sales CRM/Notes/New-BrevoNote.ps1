function New-BrevoNote
{
    <#
    .SYNOPSIS
        Creates a new note in Brevo CRM.

    .DESCRIPTION
        The New-BrevoNote cmdlet creates a new note in Brevo CRM. You can associate the note with contacts, deals, or companies by providing their respective IDs.

    .PARAMETER Text
        The text content of the note. This parameter is mandatory and must be between 1 and 3000 characters.

    .PARAMETER ContactIds
        An array of contact IDs to link to the note.

    .PARAMETER DealIds
        An array of deal IDs to link to the note.

    .PARAMETER CompanyIds
        An array of company IDs to link to the note.

    .EXAMPLE
        New-BrevoNote -Text "Followed up with the customer regarding the new proposal." -ContactIds 123 -DealIds "61a5e...","61a5f..."

        Creates a new note and links it to contact 123 and two deals.

    .LINK
        https://developers.brevo.com/reference/create-a-note
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "Text content of the note")]
        [ValidateNotNullOrEmpty()]
        [string]$Text,

        [Parameter(Mandatory = $false, HelpMessage = "Contact ids to link to a note")]
        [int[]]$ContactIds,

        [Parameter(Mandatory = $false, HelpMessage = "Deal ids to link to a note")]
        [string[]]$DealIds,

        [Parameter(Mandatory = $false, HelpMessage = "Company ids to link to a note")]
        [string[]]$CompanyIds
    )

    if (-not $PSBoundParameters.ContainsKey('DealIds') -and -not $PSBoundParameters.ContainsKey('CompanyIds') -and -not $PSBoundParameters.ContainsKey('ContactIds'))
    {
        throw "Either 'ContactIds', 'DealIds', or 'CompanyIds' must be provided as a parameter."
    }

    $uri = "/crm/notes"
    $method = "POST"

    $body = @{
        text = $Text
    }

    if ($PSBoundParameters.ContainsKey('ContactIds'))
    {
        $body.contactIds = $ContactIds
    }
    if ($PSBoundParameters.ContainsKey('DealIds'))
    {
        $body.dealIds = $DealIds
    }
    if ($PSBoundParameters.ContainsKey('CompanyIds'))
    {
        $body.companyIds = $CompanyIds
    }

    $Params = @{
        "URI"    = $uri
        "Method" = $method
        "Body"   = $body
    }

    Invoke-BrevoCall @Params
}
