function Update-ChangelogDirect
{
    <#
    .SYNOPSIS
        Updates the CHANGELOG.md with the released version and pushes directly to main.

    .DESCRIPTION
        Replaces the [Unreleased] section header in CHANGELOG.md with the current
        release version using the ChangelogManagement module, then commits and pushes
        the change directly to the current branch without opening a pull request.

        Pre-releases are skipped unless UpdateChangelogOnPrerelease is set to $true
        in the GitHubConfig section of build.yaml.

    .PARAMETER ModuleVersion
        The semantic version of the module being released (e.g. '1.2.3').

    .PARAMETER ChangelogPath
        Absolute path to CHANGELOG.md.

    .PARAMETER GitHubToken
        Personal access token used to authenticate the git push.

    .PARAMETER GitUserName
        Git user.name to use for the commit.

    .PARAMETER GitUserEmail
        Git user.email to use for the commit.

    .PARAMETER UpdateChangelogOnPrerelease
        When $false (default), the function exits early if ModuleVersion contains a
        pre-release tag (e.g. '1.2.3-preview1').
    #>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory)]
        [System.String]
        $ModuleVersion,

        [Parameter(Mandatory)]
        [System.String]
        $ChangelogPath,

        [Parameter()]
        [System.String]
        $GitHubToken = '',

        [Parameter()]
        [System.String]
        $GitUserName = '',

        [Parameter()]
        [System.String]
        $GitUserEmail = '',

        [Parameter()]
        [System.Boolean]
        $UpdateChangelogOnPrerelease = $false
    )

    if (-not $UpdateChangelogOnPrerelease -and $ModuleVersion -match '-')
    {
        Write-Build Yellow "Skipping CHANGELOG update for pre-release version '$ModuleVersion' (UpdateChangelogOnPrerelease is false)."
        return
    }

    Write-Build DarkGray "Updating '$ChangelogPath' for release v$ModuleVersion"

    Import-Module ChangelogManagement -ErrorAction Stop

    Update-Changelog -ReleaseVersion $ModuleVersion -LinkMode None -Path $ChangelogPath

    git config user.name $GitUserName
    git config user.email $GitUserEmail

    git add $ChangelogPath
    git commit -m "Updating ChangeLog since v$ModuleVersion +semver:skip"

    if ($GitHubToken)
    {
        $remoteUrl = (git remote get-url origin 2>$null).Trim()

        if ($remoteUrl -match 'github\.com[:/](?<owner>[^/]+)/(?<repo>[^/]+?)(?:\.git)?$')
        {
            $tokenUrl = "https://x-access-token`:$GitHubToken@github.com/$($Matches['owner'])/$($Matches['repo']).git"
            git remote set-url origin $tokenUrl
        }
    }

    git push origin HEAD
    if ($LASTEXITCODE -ne 0)
    {
        throw "git push failed with exit code $LASTEXITCODE"
    }
    Write-Build Green "CHANGELOG.md updated and pushed directly to main for v$ModuleVersion"
}
