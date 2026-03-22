# Brevo - A PowerShell module to automate your Brevo environment

[![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/Brevo?label=PSGallery%20Version)]()
[![PowerShell Gallery Downloads](https://img.shields.io/powershellgallery/dt/Brevo?label=Downloads)]()
![Platform](https://img.shields.io/badge/Platform-Windows|Linux|MacOS-blue)
[![GitHub Issues](https://img.shields.io/github/issues/tsubotitsch/Brevo?label=Issues)](https://github.com/tsubotitsch/Brevo/issues)

[Brevo](https://www.brevo.com) is a versatile digital marketing platform that enables businesses to streamline customer communication through multiple channels, including email, SMS, and more.

This PowerShell module provides a comprehensive set of functions to automate interactions with Brevo using the Brevo API.

For detailed API reference, see the [Brevo API documentation](https://developers.brevo.com/reference/getting-started-1).

## Functions

| General          | Contact Management                               | Marketing                 | Account and Settings     | Sales CRM        |
| ---------------- | ------------------------------------------------ | ------------------------- | ------------------------ | ---------------- |
| Connect-Brevo    | Add-BrevoContactListMember                       | Get-BrevoEmailCampaign    | Confirm-BrevoDomain      | Get-BrevoNote    |
| Disconnect-Brevo | Get-BrevoContact                                 | Remove-BrevoEmailCampaign | Get-BrevoAccount         | New-BrevoNote    |
| Invoke-BrevoCall | Get-BrevoContactAttribute                        | Send-BrevoEmailCampaign   | Get-BrevoDomain          | Remove-BrevoNote |
|                  | Get-BrevoContactEmailCampaignStatistic           |                           | Get-BrevoSender          | Update-BrevoNote |
|                  | Get-BrevoContactFolder                           |                           | Get-BrevoUser            |                  |
|                  | Get-BrevoContactList                             |                           | Get-BrevoUserActivitylog |                  |
|                  | Get-BrevoContactListMember                       |                           | Get-BrevoUserPermission  |                  |
|                  | Get-BrevoContactSegment                          |                           | New-BrevoDomain          |                  |
|                  | Import-BrevoContact                              |                           | Remove-BrevoDomain       |                  |
|                  | New-BrevoContact                                 |                           | Remove-BrevoSender       |                  |
|                  | New-BrevoContactAttributeMultipleChoiceOption    |                           | Send-BrevoUserInvitation |                  |
|                  | New-BrevoContactList                             |                           | Test-BrevoDomain         |                  |
|                  | Remove-BrevoContact                              |                           |                          |                  |
|                  | Remove-BrevoContactAttributeMultipleChoiceOption |                           |                          |                  |
|                  | Remove-BrevoContactFolder                        |                           |                          |                  |
|                  | Remove-BrevoContactList                          |                           |                          |                  |
|                  | Update-BrevoContact                              |                           |                          |                  |
|                  | Update-BrevoContactAttribute                     |                           |                          |                  |
|                  | Update-BrevoContactFolder                        |                           |                          |                  |
|                  | Update-BrevoContactList                          |                           |                          |                  |

## Getting Started

```powershell
# PowerShellGet 2.x
Install-Module -Name Brevo -Repository PSGallery

# PowerShellGet 3.x
Install-PSResource -Name Brevo

Import-Module Brevo

# List all available cmdlets provided by the module
Get-Command -Module Brevo

# Disconnect from Brevo
Disconnect-Brevo
```

## First Steps

First, you'll need an API key. [Using your API key to authenticate](https://developers.brevo.com/docs/getting-started#using-your-api-key-to-authenticate)

- Log in to [Brevo.com](https://brevo.com) or register for a free account
- Navigate to My Profile > SMTP & API > API-Key > [Generate a new API Key](https://app.brevo.com/settings/keys/api)
- Copy the generated key for later use

```powershell
# Store Credentials Securely
# $apikey = Get-Credential -Message "Please enter your Brevo API key (username doesn't matter)"
# $apikey | Export-Clixml -Path ".\Brevo-APIkey.local.xml"

$apikey = Import-Clixml -Path ".\Brevo-APIkey.local.xml"

Connect-Brevo -APIkey $apikey
```

## Retrieving Data

### List all contact attributes

```powershell
Get-BrevoContactAttribute
```

### List all contact folders

```powershell
Get-BrevoContactFolder | Format-Table
```

### List all contact lists

```powershell
Get-BrevoContactList | Format-Table
```

## Creating Data

### Create a contact folder

```powershell
New-BrevoContactFolder -Name "MyFolder01"
```

### Create a contact list

```powershell
$ContactFolder = Get-BrevoContactFolder | Where-Object { $_.name -eq "MyFolder01" }
New-BrevoContactList -Name "MyList" -FolderId $ContactFolder.id
```

### Create a contact attribute

```powershell
New-BrevoContactAttribute -AttributeCategory normal -Type text -AttributeName USERTYPE
```

### Create a new contact

```powershell
New-BrevoContact -Email "test01@example.org" -Attributes @{FNAME="Elly"; LNAME="Roger"; COUNTRIES=@("India","China")} -ListIds 22,355
```

### Complete Example

See [Create-Contacts.ps1](examples/Create-Contacts.ps1) for a complete code example
