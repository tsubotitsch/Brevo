# Changelog for Brevo

The format is based on and uses the types of changes according to [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

### [Unreleased]

### Added
- **`.devcontainer/devcontainer.json`**: Introduced a development container configuration using the .NET SDK 9.0 with support for Zsh, GitVersion, and VS Code extensions.
- **`.devcontainer/setup.ps1`**: Added setup script to install PowerShell tools, configure PATH for GitVersion, and bootstrap the module environment.
- **`.github/dependabot.yml`**: Added Dependabot configuration for monitoring `devcontainers` ecosystem weekly.
- **`.github/workflows/pr.yaml`**: Added GitHub Actions workflow for PR build and verification.
- **`.vscode/profile.ps1`**: Added profile to auto-run mini build and import the module version.
- **`tests/QA/ModulePrefix.Tests.ps1`**: Added tests to ensure the module prefix is consistent across all functions.
- **`.gitignore`**: Added diff files to the gitignore file to prevent them from being committed.
- **README.md**: Added documentation of IP Whitelisting and how to turn itt off, if needed.

### Changed

- Added function prefix `Brevo-` to all functions for consistency.

### Fixed

- Fixed pipeline
  - source/Public/Contact Management/Folder/Remove-BrevoContactFolder.ps1
  - source/Public/Contact Management/Contact/Remove-BrevoContact.ps1


## [0.3.4] - 2025.05-18

- Fixed issue with wiki sidebar generation
- Added download link to status icons at README.md

## [0.3.3] - 2025.05-02

- Fixed documentation

## [0.3.2] - 2025.05-02

- Fixed documentation

## [0.3.1] - 2025-05-02

### Added

- added Icon to the module manifest
- ProjectUri to the module manifest
- Tags to the module manifest
- Created Wiki Source Folder

## [0.2.0] - 2025-05-02

### Added

- function Add-ContactListMember
- function Confirm-Domain
- function Connect-Brevo
- function Disconnect-Brevo
- function Get-Account
- function Get-Contact
- function Get-ContactAttribute
- function Get-ContactFolder
- function Get-ContactList
- function Get-ContactListMember
- function Get-ContactSegment
- function Get-Domain
- function Get-EmailCampaign
- function Get-Sender
- function Get-User
- function Get-UserActivitylog
- function Get-UserPermission
- function Import-Contact
- function Invoke-BrevoCall
- function New-Contact
- function New-ContactAttribute
- function New-ContactFolder
- function New-ContactList
- function New-Domain
- function New-Sender
- function Remove-Contact
- function Remove-ContactAttribute
- function Remove-ContactFolder
- function Remove-ContactList
- function Remove-Domain
- function Remove-EmailCampaign
- function Remove-Sender
- function Send-EmailCampaign
- function Send-UserInvitation
- function Test-Domain
- function Update-Contact
- function Update-ContactList
