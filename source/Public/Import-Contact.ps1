function Import-Contact {
    # https://developers.brevo.com/reference/importcontacts-1
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "The path to the CSV file")]
        [string]$Path
    )
    $contacts = Import-Csv -Path $Path
    $contacts | ForEach-Object {
        $contact = New-Contact -Email $_.Email -ListId $_.ListId -Attributes $_.Attributes
        $contact
    }
    #TODO *******************************
}