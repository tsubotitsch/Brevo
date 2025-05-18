function New-WikiSidebarFromPs1 {
    param(
        [Parameter(Mandatory)]
        [string]$SourcePathPs1,
        [Parameter(Mandatory)]
        [string]$WikiSourcePath,
        [string]$SidebarFile = "_Sidebar.md"
    )

    function Build-Sidebar {
        param(
            [string]$CurrentPath,
            [int]$Depth = 0
        )
        $indent = '  ' * $Depth
        $sidebar = ""

        # Zuerst die .ps1-Dateien im aktuellen Verzeichnis
        $files = Get-ChildItem -Path $CurrentPath -Filter *.ps1 -File | Where-Object { $_.Name -notlike '*.local.*' } | Sort-Object Name
        foreach ($file in $files) {
            $relPath = $($file.BaseName)
            if ($CurrentPath -ne $SourcePath) {
                $relDir = $file.DirectoryName.Substring($SourcePath.Length).TrimStart('\', '/')
                $relPath = "$relDir/$($file.BaseName)" -replace '\\', '/'
            }
            $sidebar += "$indent- [$($file.BaseName)]($($file.BaseName))`n"
            # # .md-Datei anlegen, falls nicht vorhanden
            # $mdOutDir = Join-Path $WikiSourcePath ($file.DirectoryName.Substring($SourcePath.Length).TrimStart('\','/'))
            # if (-not (Test-Path $mdOutDir)) { New-Item -ItemType Directory -Path $mdOutDir -Force | Out-Null }
            # $mdOutFile = Join-Path $mdOutDir $mdName
            # if (-not (Test-Path $mdOutFile)) { Set-Content -Path $mdOutFile -Value "# $($file.BaseName)" }
        }

        # Danach die Unterverzeichnisse
        $dirs = Get-ChildItem -Path $CurrentPath -Directory | Sort-Object Name
        foreach ($dir in $dirs) {
            $sidebar += "$indent- $($dir.Name)`n"
            $sidebar += Build-Sidebar -CurrentPath $dir.FullName -Depth ($Depth + 1)
        }
        return $sidebar
    }

    $sidebar = "[Home](HOME.md)`n`n"
    $sidebar += "### Commands`n`n"
    $sidebar += Build-Sidebar -CurrentPath $SourcePathPs1

    $sidebarFilePath = Join-Path $WikiSourcePath $SidebarFile
    Set-Content -Path $sidebarFilePath -Value $sidebar
}

#New-WikiSidebarFromPs1 -SourcePathPs1 "C:\Users\subo\Documents\PowerShell\Modules.DEV\Brevo\source\Public" -OutputPath "C:\Users\subo\Documents\PowerShell\Modules.DEV\Brevo\output\WikiContent"