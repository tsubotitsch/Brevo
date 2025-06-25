function Import-BrevoContact {
    # https://developers.brevo.com/reference/importcontacts-1
    <#
    .SYNOPSIS
    Imports contacts into Brevo using various input formats.

    .DESCRIPTION
    The Import-BrevoContact function allows you to import contacts into Brevo using a file URL, CSV content, or JSON content. It supports various parameters to customize the import process, including list IDs, notification URL, new list creation, blacklisting options, and updating existing contacts.

    .PARAMETER fileUrl
    URL of the file to be imported (no local file). Possible file formats: .txt, .csv, .json. Mandatory if fileBody and jsonBody are not defined.

    .PARAMETER fileBody
    CSV content to be imported. Use semicolon to separate multiple attributes. Maximum allowed file body size is 10MB. Recommended safe limit is around 8 MB. Mandatory if fileUrl and jsonBody are not defined.

    .PARAMETER jsonBody
    JSON content to be imported. Maximum allowed file body size is 10MB. Recommended safe limit is around 8 MB. Mandatory if fileUrl and fileBody are not defined.

    .PARAMETER ListIds
    The IDs of the lists to which the contacts are added. Mandatory.

    .PARAMETER notifyUrl
    URL that will be called once the import process is finished.

    .PARAMETER newList
    To create a new list and import the contacts into it, pass the listName and an optional folderId.

    .PARAMETER emailBlacklist
    To blacklist all the contacts for email, set this field to true.

    .PARAMETER smsBlacklist
    To blacklist all the contacts for SMS, set this field to true.

    .PARAMETER updateExistingContacts
    To facilitate the choice to update the existing contacts, set this field to true.

    .PARAMETER emptyContactsAttributes
    Defaults to false. To facilitate the choice to erase any attribute of the existing contacts with empty value. If set to true, empty fields in your import will erase any attribute that currently contains data in Brevo. If set to false, empty fields will not affect your existing data (only available if updateExistingContacts is set to true).

    .EXAMPLE
    Import-BrevoContact -fileUrl "https://example.com/contacts.csv" -ListIds 1234

    .EXAMPLE
    Import-BrevoContact -fileBody "name;email`nJohn Doe;john@example.com" -ListIds 1234

    .EXAMPLE
    Import-BrevoContact -jsonBody '{"contacts":[{"email":"john@example.com","name":"John Doe"}]}' -ListIds 1234

    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = "Uri", HelpMessage = "Mandatory if fileBody and jsonBody is not defined. URL of the file to be imported (no local file). Possible file formats: .txt, .csv, .json")]
        [ValidatePattern('^(https?|http)://[^\s/$.?#].[^\s]*$')]
        [string]$fileUrl,
        [Parameter(Mandatory = $true, ParameterSetName = "File", HelpMessage = "Mandatory if fileUrl and jsonBody is not defined. CSV content to be imported. Use semicolon to separate multiple attributes. Maximum allowed file body size is 10MB . However we recommend a safe limit of around 8 MB to avoid the issues caused due to increase of file body size while parsing. Please use fileUrl instead to import bigger files.")]
        [string]$fileBody,
        [Parameter(Mandatory = $true, ParameterSetName = "Json", HelpMessage = "Mandatory if fileUrl and fileBody is not defined. JSON content to be imported. Maximum allowed file body size is 10MB. However we recommend a safe limit of around 8 MB to avoid the issues caused due to increase of file body size while parsing. Please use fileUrl instead to import bigger files.")]
        $jsonBody,
        [Parameter(Mandatory = $true, HelpMessage = "The IDs of the lists to which the contacts are added")]
        [int[]]$ListIds,
        [Parameter(Mandatory = $false, HelpMessage = 'URL that will be called once the import process is finished. For reference, https://help.brevo.com/hc/en-us/articles/360007666479')]
        $notifyUrl,
        [Parameter(Mandatory = $false, HelpMessage = 'To create a new list and import the contacts into it, pass the listName and an optional folderId.')]
        $newList,
        [Parameter(Mandatory = $false, HelpMessage = 'To blacklist all the contacts for email, set this field to true.')]
        [bool]$emailBlacklist,
        [Parameter(Mandatory = $false, HelpMessage = 'To blacklist all the contacts for SMS, set this field to true.')]
        [bool]$smsBlacklist,
        [Parameter(Mandatory = $false, HelpMessage = 'To facilitate the choice to update the existing contacts, set this field to true.')]
        [bool]$updateExistingContacts,
        [Parameter(Mandatory = $false, HelpMessage = 'Defaults to false
To facilitate the choice to erase any attribute of the existing contacts with empty value. emptyContactsAttributes = true means the empty fields in your import will erase any attribute that currently contain data in Brevo, & emptyContactsAttributes = false means the empty fields will not affect your existing data ( only available if updateExistingContacts set to true )')]
        [bool]$emptyContactsAttributes

    )

    $method = "POST"
    $uri = "/contacts/import"

    $body = @{}
    $fileUrl ? ($body.fileUrl = $fileUrl) : $null
    $fileBody ? ($body.fileBody = $fileBody) : $null
    $jsonBody ? ($body.jsonBody = $jsonBody) : $null
    $ListIds ? ($body.listIds = $ListIds) : $null
    $notifyUrl ? ($body.notifyUrl = $notifyUrl) : $null
    $newList ? ($body.newList = $newList) : $null
    $emailBlacklist ? ($body.emailBlacklist = $emailBlacklist) : $null
    $smsBlacklist ? ($body.smsBlacklist = $smsBlacklist) : $null
    $updateExistingContacts ? ($body.updateExistingContacts = $updateExistingContacts) : $null
    $emptyContactsAttributes ? ($body.emptyContactsAttributes = $emptyContactsAttributes) : $null
    
    $returnobject = "contacts"

    $Params = @{
        "URI"          = $uri
        "Method"       = $method
        "Body"         = $body
        "returnobject" = $returnobject
    }

    $result = Invoke-BrevoCall @Params
    return $result
}
