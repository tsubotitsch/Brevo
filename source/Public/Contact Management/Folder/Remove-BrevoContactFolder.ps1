function Remove-BrevoContactFolder {
    <#
    .SYNOPSIS
    Removes a contact folder by its ID.

    .DESCRIPTION
    The Remove-BrevoContactFolder function deletes a contact folder identified by its ID. 
    It uses the DELETE HTTP method to send a request to the specified URI.

    .PARAMETER folderId
    The unique identifier of the folder to be removed. This parameter is mandatory 
    and accepts a string value. It can also be provided via pipeline by property name.

    .INPUTS
    System.String
    The function accepts a string input for the folderId parameter.

    .OUTPUTS
    System.Object
    Returns the response object from the Invoke-BrevoCall function.

    .EXAMPLE
    Remove-BrevoContactFolder -folderId "12345"
    
    This command removes the contact folder with the ID "12345".

    .EXAMPLE
    "12345" | Remove-BrevoContactFolder

    This command removes the contact folder with the ID "12345" by passing the ID 
    through the pipeline.

    .EXAMPLE
    Get-BrevoContactFolder -folderId "12345" | Remove-BrevoContactFolder
    
    This command retrieves the contact folder with the ID "12345" and then removes it.

    .NOTES
    - This function supports ShouldProcess for safety, allowing you to confirm 
        the action before it is executed.
    - ConfirmImpact is set to 'High', so you may be prompted for confirmation 
        depending on your PowerShell settings.

    #>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "Id of the folder", Position = 0, ValueFromPipelineByPropertyName = $true )]
        [Alias ("Id")]
        [string]$folderId
    )    
    process{
        $uri = "/contacts/folders/$folderId"
        $method = "DELETE"
        $Params = @{
            "URI"    = $uri
            "Method" = $method        
        }
        if ($PSCmdlet.ShouldProcess("$Identifier", "Remove-BrevoContactFolder")) {
            $contact = Invoke-BrevoCall @Params
            Write-Information "Contact folder with ID '$folderId' has been removed." 
        }
    }
}
