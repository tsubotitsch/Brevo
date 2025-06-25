function Remove-BrevoContactAttribute {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "Category of the attribute", ValueFromPipelineByPropertyName = $true)]
        [ValidateSet("normal", "transactional", "category", "calculated", "global")]
        [Alias("AttributeCategory")]
        [string]$category,
        [Parameter(Mandatory = $true, HelpMessage = "The name of the contact attribute (case-insensitive)", ValueFromPipelineByPropertyName = $true)]
        [Alias("AttributeName")]
        [string]$Name
    )
    process {
        $method = "DELETE"
        $uri = "/contacts/attributes/$Category/$Name"
        $Params = @{
            "URI"    = $uri
            "Method" = $method
        }
        Write-Host @Params
        $attribute = Invoke-BrevoCall @Params
    }
}