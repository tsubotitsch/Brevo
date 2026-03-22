# https://api.brevo.com/v3/contacts/attributes/{attributeCategory}/{attributeName}
function Update-BrevoContactAttribute
{
    <#
	.SYNOPSIS
	Update an existing contact attribute in Brevo.

	.DESCRIPTION
	The Update-BrevoContactAttribute function updates properties of an existing contact attribute in the Brevo
	platform. Only the provided properties are sent to the API; unspecified properties are left unchanged.

	.PARAMETER Category
	Attribute category. Valid values: "normal", "transactional", "category", "calculated", "global".

	.PARAMETER Name
	Existing name of the attribute to update.

	.PARAMETER NewName
	New name for the attribute. Use if you want to rename the attribute.

	.PARAMETER Type
	Type of the attribute. Valid values: "text", "date", "float", "boolean", "multiple-choice", "id", "category".

	.PARAMETER Enumeration
	Enumeration values (for category attributes). Provide as a hashtable or array as required by the API.

	.PARAMETER MultiCategoryOptions
	Options to add for a multiple-choice attribute.

	.PARAMETER Value
	Value used for calculated or global attributes.

	.PARAMETER IsRecurring
	Boolean indicating whether the attribute is recurring (calculated/global).

	.EXAMPLE
	PS C:\> Update-BrevoContactAttribute -Category normal -Name FirstName -Type text

	Updates the attribute "FirstName" in the "normal" category to type "text".

	.EXAMPLE
	PS C:\> Update-BrevoContactAttribute -Category normal -Name Status -Enumeration @{Active=1; Inactive=0}

	Updates the enumeration for the "Status" attribute in the "normal" category.

	.OUTPUTS
	Returns the updated attribute object on success, or $null on error.
	#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "Category of the attribute")]
        [ValidateSet("normal", "transactional", "category", "calculated", "global")]
        [Alias ("attributeCategory")]
        [string]$Category,

        [Parameter(Mandatory = $true, HelpMessage = "The existing name of the attribute")]
        [Alias ("attributeName")]
        [string]$Name,

        [Parameter(Mandatory = $false, HelpMessage = "New name for the attribute")]
        [string]$NewName,

        [Parameter(Mandatory = $false, HelpMessage = "Type of the attribute")]
        [ValidateSet("text", "date", "float", "boolean", "multiple-choice", "id", "category")]
        [string]$Type,

        [Parameter(Mandatory = $false, HelpMessage = "Enumeration values for category attributes")]
        $Enumeration,

        [Parameter(Mandatory = $false, HelpMessage = "Options for multiple-choice attributes, e.g. @('Option1', 'Option2')")]
        [Alias ("MultipleChoiceOption")]
        $MultiCategoryOption,

        [Parameter(Mandatory = $false, HelpMessage = "Value for calculated/global attributes")]
        $Value,

        [Parameter(Mandatory = $false, HelpMessage = "Indicates whether the attribute is recurring")]
        [bool]$IsRecurring
    )

    begin
    {
        $uri = "/contacts/attributes/$Category/$Name"
        $method = 'PUT'
        $body = @{}
        if ($PSBoundParameters.ContainsKey('NewName'))
        {
            $body.name = $NewName 
        }
        if ($PSBoundParameters.ContainsKey('Type'))
        {
            $body.type = $Type 
        }
        if ($PSBoundParameters.ContainsKey('Enumeration'))
        {
            $body.enumeration = $Enumeration 
        }
        if ($PSBoundParameters.ContainsKey('MultiCategoryOption'))
        {
            $body.multiCategoryOptions = @($MultiCategoryOption)
        }
        if ($PSBoundParameters.ContainsKey('Value'))
        {
            $body.value = $Value 
        }
        if ($PSBoundParameters.ContainsKey('IsRecurring'))
        {
            $body.isRecurring = $IsRecurring 
        }

        if ($body.Count -eq 0)
        {
            Write-Error "No properties specified to update. Provide at least one property (e.g. -NewName, -Type, -Enumeration)."
            return $null
        }

        $Params = @{
            URI          = $uri
            Method       = $method
            Body         = $body
            returnobject = 'attributes'
        }
    }

    process
    {
        if ($PSCmdlet.ShouldProcess("$Category/$Name", 'Update contact attribute'))
        {
            try
            {
                $updated = Invoke-BrevoCall @Params
                return $updated
            }
            catch
            {
                # Respect -ErrorAction; do not re-throw here.
                Write-Error $_.Exception.Message
                return $null
            }
        }
    }
}
