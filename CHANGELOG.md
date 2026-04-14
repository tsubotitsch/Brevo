# Changelog for Brevo

The format is based on and uses the types of changes according to [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.7.0] - 2026-04-14

### Fixed

- publish.ps1: updated pipeline

## [0.7.0] - 2026-04-14

### Added

#### build.ps1
- Introduced a new task `Update_Wiki_Home` that synchronizes the project `README.md` with the GitHub Wiki home page.
  - Copies `README.md` content into `WikiContent/Home.md`.
  - Automatically generates a `_Footer.md` file containing:
    - The current UTC timestamp.
    - The semantic version retrieved via `dotnet-gitversion`.
  - Ensures the target wiki directory exists before writing files.
  - Provides logging output and error handling for missing README scenarios.
  - Enhances documentation consistency by keeping the wiki homepage aligned with the repository README.

- Added a new task `Update_Changelog_Direct` to automate changelog updates during the build process.
  - Invokes `Update-ChangelogDirect` with dynamically resolved parameters.
  - Supports authentication via multiple environment variables (`GitHubToken`, `GITHUB_TOKEN`).
  - Configures Git user identity from build configuration or environment variables.
  - Adds support for conditional changelog updates on prerelease versions.
  - Improves CI/CD automation by integrating changelog generation directly into the pipeline.

### Changed

#### build.yaml
- Modified build workflow task execution:
  - Disabled documentation generation steps (`Generate_Markdown_For_Public_Commands`, `Generate_MAML_from_built_module`) in the default build pipeline.
  - Reordered and expanded wiki-related tasks:
    - Added `Update_Wiki_Home` to ensure the wiki homepage is updated during documentation packaging.
    - Adjusted placement of `Generate_Wiki_Sidebar_From_Ps1` for improved sequencing.
    - Added optional hooks for custom wiki content handling.
  - Updated `publish` pipeline sequence:
    - Moved `Publish_GitHub_Wiki_Content` to run last, ensuring module publishing is not blocked by documentation issues.
    - Introduced `Update_Changelog_Direct` before publishing to automate changelog updates as part of release flow.
  - Removed the `updatedocs` workflow, simplifying the pipeline structure.

- Updated configuration for `Publish_GitHub_Wiki_Content`:
  - Disabled debug mode (`Debug: false`) to reduce verbosity in build output.


## [0.6.0] - 2026-04-14

### Added

#### Companies
- function Get-BrevoCompany - Retrieves a single company by ID or lists multiple companies with pagination and sorting
- function New-BrevoCompany - Creates a new company with name and optional contact information
- function Update-BrevoCompany - Updates company properties (name, email, phone, website, address, etc.)
- function Remove-BrevoCompany - Deletes a company
- function Set-BrevoCompanyLink - Links or unlinks contacts and deals to/from a company

#### Deals
- function Get-BrevoDeal - Retrieves a single deal by ID or lists multiple deals with pagination and sorting
- function New-BrevoDeal - Creates a new deal with title, value, pipeline, and optional linked contacts/companies
- function Update-BrevoDeal - Updates deal properties (title, value, status, stage, probability, etc.)
- function Remove-BrevoDeal - Deletes a deal
- function Set-BrevoDealLink - Links or unlinks contacts and companies to/from a deal

#### Tasks
- function Get-BrevoTask - Retrieves a single task by ID or lists multiple tasks with pagination
- function New-BrevoTask - Creates a new task with name, description, due date, priority, and linked entities
- function Update-BrevoTask - Updates task properties (name, description, status, priority, assignment, etc.)
- function Remove-BrevoTask - Deletes a task

#### Pipelines
- function Get-BrevoPipeline - Retrieves pipeline details and stages by ID or lists all pipelines

#### Files
- function Get-BrevoCrmFile - Retrieves a single file by ID or lists multiple files with pagination
- function New-BrevoCrmFile - Uploads a new file and optionally links it to deals, contacts, or companies
- function Remove-BrevoCrmFile - Deletes a file

### Fixed

- **New-BrevoCrmFile**: Added try/catch around `Get-Item` to surface a clear error when the file does not exist or is not readable

#### Attributes
- function Get-BrevoCrmAttribute - Retrieves custom attributes for a specific entity type (deals or companies)
- function New-BrevoCrmAttribute - Creates a new custom attribute for deals or companies
- function Remove-BrevoCrmAttribute - Deletes a custom attribute

## [0.5.0] - 2026-03-22

## Added
 - function Get-BrevoNote
 - function New-BrevoNote
 - function Remove-BrevoNote
 - function Update-BrevoNote

## [0.4.1] - 2026-03-22

### Added

- function Update-BrevoContactAttribute
- function New-BrevoContactAttributeMultipleChoiceOption
- function Remove-BrevoContactAttributeMultipleChoiceOption
- function Get-BrevoContactEmailCampaignStatistic
- function Update-BrevoContactFolder

## Changed

- **source\Public\Contact Management\Contact\New-BrevoContact.ps1** Added option 'CreateMultiChoiceOptions' to add MultiChoiceOptions automatically
- **source\Public\Contact Management\Remove-BrevoContactAttribute.ps1** Removed debug output
- **source\Public\Contact Management\Attribute\Get-BrevoContactAttribute.ps1** Added filter for type and category
- **source\Public\Contact Management\Attribute\Update-BrevoContactAttribute.ps1** Added option 'AddMultiChoiceOptions' to add values to existing multi-choice options instead replacing them

### Fixed

- **source\Public\Contact Management\Contact\Get-BrevoContact.ps1** Fixed Id/Email/none parameter
- **source\Public\Invoke-BrevoCall.ps1** Fixed errorhandling for ErrorAction
- **source\Public\Contact Management\Contact\New-BrevoContact.ps1** Pass parameter to update contact to API call
- **source\Public\Contact Management\Attribute\Update-BrevoContactAttribute.ps1** Fixed attribute handling

## [0.4.0] - 2025-06-25

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


## [0.3.4] - 2025-05-18

- Fixed issue with wiki sidebar generation
- Added download link to status icons at README.md

## [0.3.3] - 2025-05-02

- Fixed documentation

## [0.3.2] - 2025-05-02

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
