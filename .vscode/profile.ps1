if($pwd -notlike "*/Brevo") {
    Set-Location "$env:USERPROFILE\Documents\PowerShell\Modules.DEV\Brevo"
}
./build.ps1 -tasks minibuild
$version = dotnet-gitversion /showvariable MajorMinorPatch /nocache
$ModuleFile = ".\output\module\Brevo\$version\Brevo.psd1"
Import-Module $ModuleFile
