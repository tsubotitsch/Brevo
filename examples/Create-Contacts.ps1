# Brevo Demo Script
$ErrorActionPreference = "Stop"

if (-not (Get-Module -ListAvailable -Name Brevo)) {
    Import-Module Brevo
}

$apikey ??= Get-Credential

# Connect will fail if source IP is not whitelisted at the Brevo account.
Connect-Brevo -APIkey $apikey

Get-BrevoContactFolder | Format-Table

Get-BrevoContactList | Format-Table

## Create a contact folder
$ContactFolder = New-BrevoContactFolder -Name "PSconf2025"
$ContactFolder

# Create a contact list
$ContactList = New-BrevoContactList -Name "BrevoPresentation" -FolderId $ContactFolder.id
$ContactList

# For creating contacts, we have to know which attributes are available. (otherwise we've to create them)
Get-BrevoContactAttribute

New-BrevoContact -Email "Bud.Spencer@example.org" -attributes @{VORNAME = "Bud"; NACHNAME = "Spencer"; COUNTRIES = @("Italy", "America") } -ListIds @($ContactList.id)

# Apearance in GUI

$firstNames = @("Elly", "John", "Sara", "Mike", "Anna", "Tom", "Lily", "Chris", "Nina", "Paul")
$lastNames = @("Roger", "Smith", "Brown", "Lee", "Patel", "Kim", "Chen", "Singh", "Garcia", "Jones")
$countries = @("India", "China", "USA", "UK", "Germany", "France", "Japan", "Brazil", "Canada", "Australia")
$listIds = @($ContactList.id)

for ($i = 1; $i -le 10; $i++) {
    $fname = Get-Random -InputObject $firstNames
    $lname = Get-Random -InputObject $lastNames
    $email = "$($fname.ToLower()).$($lname.ToLower())$i@example.org"
    $selectedCountries = Get-Random -InputObject $countries -Count 2

    New-BrevoContact -Email $email `
        -attributes @{VORNAME = $fname; NACHNAME = $lname; COUNTRIES = $selectedCountries } `
        -ListIds $listIds
}
