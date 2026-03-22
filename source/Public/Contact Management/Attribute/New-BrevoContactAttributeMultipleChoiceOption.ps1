function New-BrevoContactAttributeMultipleChoiceOption
{
    <#
	.SYNOPSIS
	Add one or more options to a multiple-choice contact attribute in Brevo.

	.DESCRIPTION
	The New-BrevoContactAttributeMultipleChoiceOption function adds options to an existing
	multiple-choice contact attribute. This implementation delegates to
	`Update-BrevoContactAttribute`.

	.PARAMETER attributeCategory
	Attribute category. Valid values: "normal", "transactional", "category", "calculated", "global".

	.PARAMETER attributeName
	Name of the existing attribute (will be converted to uppercase).

	.PARAMETER Option
	Array of options to add. The structure depends on API expectations: typically an array
	of strings or objects containing `value`/`label` pairs. Example: @('OptA','OptB') or @(@{label='A'; value='a'})

    .EXAMPLE
	PS C:\> New-BrevoContactAttributeMultipleChoiceOption -Category normal -Name Tags -Option 'OptA'

	Adds option 'OptA' to the multiple-choice attribute `Tags`.

    .EXAMPLE
	PS C:\> New-BrevoContactAttributeMultipleChoiceOption -Name Tags -Option @('OptA','OptB')

	Adds two options to the multiple-choice attribute `Tags`.

	.OUTPUTS
	Returns the API response object on success, or $null on failure.
	#>

    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param (
        [Parameter(Mandatory = $false, HelpMessage = 'Category of the attribute')]
        [ValidateSet('normal', 'transactional', 'category', 'calculated', 'global')]
        [string]$Category = "normal",

        [Parameter(Mandatory = $true, HelpMessage = 'The name of the contact attribute (will be converted to uppercase)')]
        [string]$Name,

        [Parameter(Mandatory = $true, HelpMessage = 'Option to add to the multiple-choice attribute ', ValueFromPipeline = $true)]
        $Option
    )

    process
    {
        $Name = $Name.ToUpper()

        try
        {
            # Delegate to Update-BrevoContactAttribute to keep logic centralized
            $updated = Update-BrevoContactAttribute -Category $Category -Name $Name -MultiCategoryOption $Option
            return $updated
        }
        catch
        {
            Write-Error $_.Exception.Message
            return $null
        }

    }
}
