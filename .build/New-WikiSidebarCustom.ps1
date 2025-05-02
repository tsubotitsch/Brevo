#Region './Private/New-WikiSidebar.ps1' -1

<#
    .SYNOPSIS
        Creates the Wiki side bar file from the list of markdown files in the path.

    .DESCRIPTION
        Creates the Wiki side bar file from the list of markdown files in the path.

    .PARAMETER ModuleName
        The name of the module to generate a new Wiki Sidebar file for.

    .PARAMETER OutputPath
        The path in which to create the Wiki Sidebar file, e.g. '.\output\WikiContent'.


    .PARAMETER WikiSourcePath
        The path where to find the markdown files that was generated
        by New-DscResourceWikiPage, e.g. '.\output\WikiContent'.

    .PARAMETER BaseName
        The base name of the Wiki Sidebar file. Defaults to '_Sidebar.md'.

    .EXAMPLE
        New-WikiSidebar -ModuleName 'ActiveDirectoryDsc -Path '.\output\WikiContent'

        Creates the Wiki side bar from the list of markdown files in the path.
#>
function New-WikiSidebarCustom {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '')]
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $ModuleName,

        [Parameter(Mandatory = $true)]
        [System.String]
        $OutputPath,

        [Parameter(Mandatory = $true)]
        [System.String]
        $WikiSourcePath,

        [Parameter()]
        [System.String]
        $BaseName = '_Sidebar.md',

        [Parameter()]
        [switch]$addHirachy = $false
    )

    $wikiSideBarOutputPath = Join-Path -Path $OutputPath -ChildPath $BaseName
    $wikiSideBarWikiSourcePath = Join-Path -Path $WikiSourcePath -ChildPath $BaseName

    if (-not (Test-Path -Path $wikiSideBarWikiSourcePath)) {
        Write-Verbose -Message ($script:localizedData.GenerateWikiSidebarMessage -f $BaseName)

        $WikiSidebarContent = @(
            "# $ModuleName Module"
            ' '
        )

       
        function Add-MarkdownFilesToSidebar {
            param (
                [string]$Path,
                [int]$Depth = 0
            )

            $indent = '  ' * $Depth
            $items = Get-ChildItem -Path $Path | Sort-Object { -not $_.PSIsContainer }, Name
            Write-Verbose -Message "$($items.Count) items found in $Path"

            foreach ($item in $items) {
                if ($item.PSIsContainer) {
                    $WikiSidebarContent += "$indent- **$($item.Name)**`n"
                    write-verbose -Message "PSIsContainer: $indent- **$($item.Name)**"
                    Add-MarkdownFilesToSidebar -Path $item.FullName -Depth ($Depth + 1)
                }
                elseif ($item.Extension -eq '.md' -and $item.Name -notmatch '^_.*\.md$') {
                    $relativePath = $item.FullName.Substring($OutputPath.Length).TrimStart('\', '/') -replace '\\', '/'
                    $WikiSidebarContent += "$indent- [$($item.BaseName)]($relativePath)`n"
                    write-verbose -Message "no PSIsContainer: $indent- [$($item.BaseName)]($relativePath)"
                }
            }
            return $WikiSidebarContent
        }

        $WikiSidebarContent = Add-MarkdownFilesToSidebar -Path $WikiSourcePath

        Out-File -InputObject $WikiSidebarContent -FilePath $wikiSideBarOutputPath -Encoding 'ascii'
    }
}
#EndRegion './Private/New-WikiSidebar.ps1' 74