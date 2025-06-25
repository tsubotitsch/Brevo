# Brevo - A PowerShell module to automate your Brevo environment

[![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/Brevo?label=PSGallery%20Version)]()
[![PowerShell Gallery Downloads](https://img.shields.io/powershellgallery/dt/Brevo?label=Downloads)]()
![Platform](https://img.shields.io/badge/Platform-Windows|Linux|MacOS-blue)
[![GitHub Issues](https://img.shields.io/github/issues/tsubotitsch/Brevo?label=Issues)](https://github.com/tsubotitsch/Brevo/issues)

[Brevo](https://www.brevo.com) is a versatile digital marketing platform that enables businesses to streamline customer communication through multiple channels, including email, SMS, and more.

This PowerShell module contains functions to automate Brevo via the Brevo API

See [Brevo API documentation](https://developers.brevo.com/reference/getting-started-1)

## Functions

| General          | Contact Management    | Marketing           | Account and Settings |
| ---------------- | --------------------- | ------------------- | -------------------- |
| Connect-Brevo    | Add-BrevoContactListMember | Get-BrevoEmailCampaign    | Get-BrevoUser             |
| Disconnect-Brevo | Get-BrevoContact           | Remove-BrevoEmailCampaign | Get-BrevoUserActivitylog  |
| Invoke-BrevoCall | Get-BrevoContactAttribute  | Send-BrevoEmailCampaign   | Get-BrevoUserPermission  |
|                  | Get-BrevoContactFolder     |                     | Send-BrevoUserInvitation  |
|                  | Get-BrevoContactList       |                     |                      |
|                  | Get-BrevoContactListMember |                     | Confirm-BrevoDomain       |
|                  | Get-BrevoContactSegment    |                     | Get-BrevoDomain           |
|                  | Import-BrevoContact        |                     | New-BrevoDomain           |
|                  | New-BrevoContact           |                     | Remove-BrevoDomain        |
|                  | Update-BrevoContact        |                     | Get-BrevoAccount          |
|                  | Remove-BrevoContact        |                     | Get-BrevoSender           |
|                  | New-BrevoContactList       |                     |                      |
|                  |                       |                     | New-BrevoDomain           |
|                  |                       |                     | Remove-BrevoDomain        |
|                  |                       |                     | Test-BrevoDomain          |

## How to start?

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

## 1st steps

You have to have an API key first. [Using your API key to authenticate](https://developers.brevo.com/docs/getting-started#using-your-api-key-to-authenticate)

- Login to [Brevo.com](https://brevo.com) or register for free
- Navigate to My Profile > SMTP & API > API-Key > [Generate ne API Key](https://app.brevo.com/settings/keys/api)
- Copy the generated key for later use

```powershell
# Create Credentials
# $apikey = Get-credential -Message "Please enter your Brevo API key (username doesn't matter)"
# $apikey | Export-Clixml -Path ".\Brevo-APIkey.local.xml"

$apikey = Import-Clixml -Path ".\Brevo-APIkey.local.xml"

Connect-Brevo -APIkey $apikey
```

## Retrieving data

### List all attributes

```powershell
Get-BrevoContactAttributes
```

### List all contact folders

```powershell
Get-BrevoContactFolder | Format-Table
```

### List all contact lists

```powershell
Get-BrevoContactList | Format-Table
```

## Creating data

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
New-BrevoContactAttribute -attributeCategory normal -type text -attributeName USERTYPE
```

## Create a new contact

```powershell
New-BrevoContact -Email "test01@example.org" -attributes @{FNAME="Elly"; LNAME="Roger";COUNTRIES=@("India","China")} -listIds 22,355
```
