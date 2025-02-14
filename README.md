# Brevo

PowerShell functions for Brevo API

See [Brevo API documentation](https://developers.brevo.com/reference/getting-started-1)

## Functions
- Connect-Brevo
- Get-ContactAttribute
- Get-ContactFolder
- Get-ContactList
- New-Contact
- New-ContactAttribute
- New-ContactFolder
- New-ContactList
- Update-Contact

- Invoke-BrevoCall

## How to start?

```powershell
Install-Module Brevo
Import-Module Brevo

Get-Command -Module Brevo
```

# 1st attempt

```powershell
# Create Credentials
# $apikey = Get-credential -Message "Please enter your Brevo API key (username doesn't matter)"
# $apikey | Export-Clixml -Path ".\Brevo-APIkey.local.xml"
$apikey = Import-Clixml -Path ".\Brevo-APIkey.local.xml"

Connect-Brevo -APIkey $apikey
```

# Retieving data

## List all attributes
```powershell
Get-ContactAttributes
```

## List all contact folders
```powershell
Get-ContactFolder | Format-Table
```

## List all contact lists
```powershell
Get-ContactList | Format-Table
```

# Creating data

## Create a contact folder
```powershell
New-ContactFolder -Name "MyFolder01"
```



## Create a contact list
```powershell
$ContactFolder = Get-ContactFolder | Where-Object { $_.name -eq "MyFolder01" }
New-ContactList -Name "MyList" -FolderId $ContactFolder.id
```
## Create a contact attribute
```powershell

```

# Todo
- Add missing function to module