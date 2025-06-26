
function Remove-BrevoContactAttribute {
    <#
    .SYNOPSIS
    Removes a contact attribute from the Brevo system.

    .DESCRIPTION
    The Remove-BrevoContactAttribute function deletes a specified contact attribute from a given category in the Brevo platform. This operation is high impact and supports confirmation prompts.

    .PARAMETER category
    The category of the attribute to remove. Valid values are: normal, transactional, category, calculated, global.

    .PARAMETER Name
    The name of the contact attribute to remove (case-insensitive).

    .EXAMPLE
    Remove-BrevoContactAttribute -category "normal" -Name "FirstName"

    Removes the "FirstName" attribute from the "normal" category.

    .EXAMPLE
    @{ category = "transactional"; Name = "LastName" } | Remove-BrevoContactAttribute

    This example demonstrates how to pass the parameters as a hashtable to remove the "LastName" attribute from the "transactional" category.

    .EXAMPLE
    @({ category = "category"; Name = "Status" }, @{ category = "global"; Name = "OptIn" }) | Remove-BrevoContactAttribute

    This example shows how to remove multiple attributes by passing an array of hashtables, each containing the category and name of the attribute to be removed.

    .INPUTS
    None. You cannot pipe objects to this function.

    .OUTPUTS
    None. The function does not return any output.

    #>
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
        if($PSCmdlet.ShouldProcess("$Name", "Remove-BrevoContactAttribute")) {
            Write-Verbose "Removing contact attribute: $Name from category: $Category"
            # Invoke the API call to remove the contact attribute
            # The Invoke-BrevoCall function is assumed to handle the API request
            $attribute = Invoke-BrevoCall @Params
            Write-Information "Removed contact attribute: $Name from category: $Category"
            return $attribute
        }

    }
}
