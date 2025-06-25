BeforeDiscovery {
    $projectPath = "$($PSScriptRoot)\..\.." | Convert-Path

    <#
        If the QA tests are run outside of the build script (e.g with Invoke-Pester)
        the parent scope has not set the variable $ProjectName.
    #>
    if (-not $ProjectName)
    {
        # Assuming project folder name is project name.
        $ProjectName = Get-SamplerProjectName -BuildRoot $projectPath
    }

    $script:moduleName = $ProjectName

    Remove-Module -Name $script:moduleName -Force -ErrorAction SilentlyContinue

    $mut = Get-Module -Name $script:moduleName -ListAvailable |
        Select-Object -First 1 |
            Import-Module -Force -ErrorAction Stop -PassThru
}

Describe "Module Function Name Prefix Validation" {
    It "All exported functions should follow the naming convention <Verb>-<Prefix><FunctionName>" {
        # Get all exported functions from the module
        $exportedFunctions = $mut.ExportedCommands.Keys

        # Define the regex pattern with named groups
        $namingPattern = "^(?<Verb>[A-Za-z]+)-(?<Prefix>$script:moduleName)(?<FunctionName>[A-Za-z]+)$"

        # Iterate through each function and validate the naming convention
        foreach ($functionName in $exportedFunctions) {
            $functionName | Should -Match $namingPattern
        }
    }
}