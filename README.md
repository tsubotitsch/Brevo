# Brevo

PowerShell functions for Brevo API

See [Brevo API documentation](https://developers.brevo.com/reference/getting-started-1)

## Functions

| General          | Contact Management   | Marketing           | Account and Settings |
| ---------------- | -------------------- | ------------------- | -------------------- |
| Connect-Brevo    | Get-Contact          | Get-EmailCampain    | Get-User             |
| Invoke-BrevoCall | Get-ContactAttribute | Remove-EmailCampain | Get-UserPermission   |
|                  | Get-ContactFolder    | Send-EmailCampain   | Send-UserInvitation  |
|                  | Get-ContactList      |                     |                      |
|                  | Import-Contact       |                     | Confirm-Domain       |
|                  | New-Contact          |                     | Get-Domain           |
|                  | New-ContactAttribute |                     | New-Domain           |
|                  | New-ContactFolder    |                     | Remove-Domain        |
|                  | New-ContactList      |                     | Test-Domain          |
|                  | Remove-Contact       |                     |                      |
|                  | Update-Contact       |                     | Get-Sender           |
|                  |                      |                     | New-Sender           |
|                  |                      |                     | Remove-Sender        |

## How to start?

```powershell
# PowerShellGet 2.x
Install-Module -Name Brevo -Repository PSGallery

# PowerShellGet 3.x
Install-PSResource -Name Brevo

Import-Module Brevo

# List all available cmdlets provided by the module
Get-Command -Module Brevo
```

## 1st steps

You have to have an API key first.

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
