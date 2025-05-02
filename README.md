# Brevo - A PowerShell module to automate your Brevo environment

![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/Brevo?label=PSGallery%20Version)
![PowerShell Gallery Downloads](https://img.shields.io/powershellgallery/dt/Brevo?label=Downloads)
![Platform](https://img.shields.io/badge/Platform-Windows|Linux|MacOS-blue)
![GitHub Issues](https://img.shields.io/github/issues/tsubotitsch/Brevo?label=Issues)

[Brevo](https://www.brevo.com) is a versatile digital marketing platform that enables businesses to streamline customer communication through multiple channels, including email, SMS, and more.

This PowerShell module contains functions to automate Brevo via the Brevo API

See [Brevo API documentation](https://developers.brevo.com/reference/getting-started-1)

## Functions

| General          | Contact Management    | Marketing           | Account and Settings |
| ---------------- | --------------------- | ------------------- | -------------------- |
| Connect-Brevo    | Add-ContactListMember | Get-EmailCampaign    | Get-User             |
| Disconnect-Brevo | Get-Contact           | Remove-EmailCampaign | Get-UserActivitylog  |
| Invoke-BrevoCall | Get-ContactAttribute  | Send-EmailCampaign   | Get-UserPermission  |
|                  | Get-ContactFolder     |                     | Send-UserInvitation  |
|                  | Get-ContactList       |                     |                      |
|                  | Get-ContactListMember |                     | Confirm-Domain       |
|                  | Get-ContactSegment    |                     | Get-Domain           |
|                  | Import-Contact        |                     | New-Domain           |
|                  | New-Contact           |                     | Remove-Domain        |
|                  | New-ContactAttribute  |                     | Test-Domain          |
|                  | New-ContactFolder     |                     |                      |
|                  | Remove-Contact        |                     | Get-Sender           |
|                  | Remove-ContactAttribute |                   | New-Sender           |
|                  | Remove-ContactFolder  |                     | Remove-Sender        |
|                  | Remove-ContactList    |                     |                      |
|                  | Update-Contact        |                     | Get-Account          |
|                  | Update-ContactList    |                     |                      |
|                  |                       |                     | New-Domain           |
|                  |                       |                     | Remove-Domain        |
|                  |                       |                     | Test-Domain          |

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
Get-ContactAttributes
```

### List all contact folders

```powershell
Get-ContactFolder | Format-Table
```

### List all contact lists

```powershell
Get-ContactList | Format-Table
```

## Creating data

### Create a contact folder

```powershell
New-ContactFolder -Name "MyFolder01"
```

### Create a contact list

```powershell
$ContactFolder = Get-ContactFolder | Where-Object { $_.name -eq "MyFolder01" }
New-ContactList -Name "MyList" -FolderId $ContactFolder.id
```

### Create a contact attribute

```powershell
New-ContactAttribute -attributeCategory normal -type text -attributeName USERTYPE
```

## Create a new contact

```powershell
New-Contact -Email "test01@example.org" -attributes @{FNAME="Elly"; LNAME="Roger";COUNTRIES=@("India","China")} -listIds 22,355
```
