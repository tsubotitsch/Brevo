# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Brevo is a PowerShell 7.0+ module wrapping the Brevo REST API v3 (digital marketing platform). It provides cmdlets for managing contacts, email campaigns, domains, users, and Sales CRM (notes, deals, companies, tasks). It follows the **Sampler/ModuleBuilder** framework — a standardized PowerShell module build pattern that merges source files into a distributable module artifact.

## Build Commands

```powershell
# Full build (first time or after dependency changes)
./build.ps1 -ResolveDependency -UseModuleFast

# Light build (no docs generation)
./build.ps1 -Tasks minibuild

# Full build with docs
./build.ps1 -Tasks build

# Run tests
./build.ps1 -AutoRestore -Tasks test

# Run a single Pester test file
Invoke-Pester -Path ./tests/Unit/Public/SomeCmdlet.tests.ps1 -PassThru

# Package for distribution
./build.ps1 -Tasks pack
```

VS Code tasks (`Ctrl+Shift+B`) map to the build task defined in `.vscode/tasks.json`.

CI/CD (GitHub Actions) runs on push to `main`: builds, packs, and publishes to PowerShell Gallery.

## Architecture

### Core pattern: API wrapper

All public cmdlets are thin wrappers around `Invoke-BrevoCall` ([source/Public/Invoke-BrevoCall.ps1](source/Public/Invoke-BrevoCall.ps1)), which handles HTTP methods, pagination, JSON serialization, and error handling for the Brevo REST API (`https://api.brevo.com/v3`).

### Session state

`Connect-Brevo` stores two script-scoped variables used by every subsequent call:
- `$script:APIuri` — base API URL
- `$script:APIkey` — credential object containing the API key

`Disconnect-Brevo` clears them.

### Public cmdlets

67 cmdlets under [source/Public/](source/Public/), organized into subdirectories by feature area:
- `Contact Management/` — Contact, Folder, List, Attribute, Segment
- `Marketing/` — email campaigns
- `Account and Settings/` — Domains, Users, Senders
- `Sales CRM/` — Notes, Deals, Companies, Tasks

### Build system

Uses the [Sampler](https://github.com/gaelcolas/Sampler) framework. `build.yaml` defines the task workflows (build, test, docs, pack, publish). `build.ps1` is the entry point. Module source is compiled by ModuleBuilder into `output/`.

### Versioning

GitVersion calculates semantic versions from Git history (`GitVersion.yml`). The version in `source/Brevo.psd1` is managed automatically during build.

## Adding New Cmdlets

1. Create `source/Public/<Category>/Verb-BrevoNoun.ps1` with comment-based help (`.SYNOPSIS`, `.DESCRIPTION`, `.PARAMETER`, `.EXAMPLE`).
2. Call `Invoke-BrevoCall` internally — do not call `Invoke-RestMethod` directly.
3. Add a corresponding test in `tests/Unit/Public/Verb-BrevoNoun.tests.ps1`.
4. Code coverage threshold is 85% — new cmdlets need test coverage.
5. Update `CHANGELOG.md` under the `## [Unreleased]` section (Keep a Changelog format) before opening a PR.

## Testing Notes

- Test framework: Pester (latest)
- QA tests in `tests/QA/` validate module structure and naming conventions (all public functions must have the `Brevo` prefix).
- Unit tests in `tests/Unit/Public/` and `tests/Unit/Private/`.
- Linting via PSScriptAnalyzer is part of the build pipeline.

## Changelog Conventions

After every code or config change, always update `CHANGELOG.md` under the `[Unreleased]` section as part of the same response — do not wait to be asked. Use Keep a Changelog conventions (`Added`, `Changed`, `Fixed`, `Removed`) and match the existing entry style in the file.
