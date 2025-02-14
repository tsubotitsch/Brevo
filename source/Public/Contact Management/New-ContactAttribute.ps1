function New-ContactAttribute {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "Category of the attribute")]
        [ValidateSet("normal", "transactional", "category", "calculated", "global")]
        $attributeCategory,

        [Parameter(Mandatory = $true, HelpMessage = "The name of the attribute")]
        $attributeName,

        [Parameter(Mandatory = $false, HelpMessage = "Value of the attribute. Use only if the attribute's category is 'calculated' or 'global'")]
        [ValidateSet("calculated", "global")]
        $value,

        [Parameter(Mandatory = $false, HelpMessage = "Type of the attribute. Use only if the attribute's category is 'calculated' or 'global'")]
        [ValidateSet("calculated", "global")]
        $isRecurring,
            
        [Parameter(Mandatory = $false, HelpMessage = "List of values and labels that the attribute can take. Use only if the attribute's category is 'category'")]
        $enumeration,

        [Parameter(Mandatory = $false, HelpMessage = "List of options you want to add for multiple-choice attribute. Use only if the attribute's category is 'normal' and attribute's type is 'multiple-choice'.")]
        $multiCategoryOptions,

        [Parameter(Mandatory = $false, HelpMessage = "Type of the attribute. Use only if the attribute's category is 'normal', 'category' or 'transactional'
Type boolean and multiple-choice is only available if the category is normal attribute Type id is only available if the category is transactional attribute
Type category is only available if the category is category attribute")]
        [ValidateSet("text", "date", "float", "boolean", "multiple-choice", "id", "category")]
        $type = "text"

    )
    $uri = "/contacts/attributes" + "/" + $attributeCategory + "/" + $attributeName
    $method = "POST"
    $body = @{}
    $value ? $(body.value = $value) : $null
    $isRecurring ? ($body.isRecurring = $isRecurring) : $null
    $enumeration ? ($body.enumeration = $enumeration) : $null
    $multiCategoryOptions ? ($body.multiCategoryOptions = $multiCategoryOptions) : $null
    $body.type = $type

    $Params = @{
        "URI"    = $uri
        "Method" = $method
        "Body"   = $body
        "returnobject" = "attributes"
    }
    $attribute = Invoke-BrevoCall @Params
    return $attribute
}