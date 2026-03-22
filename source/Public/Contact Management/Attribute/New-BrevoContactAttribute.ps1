function New-BrevoContactAttribute {
    <#
    .SYNOPSIS
    Creates a new contact attribute in Brevo.

    .DESCRIPTION
    The New-BrevoContactAttribute function creates a new contact attribute in Brevo with the specified category, name, and other optional parameters.

    .PARAMETER Category
    Specifies the category of the attribute. Valid values are "normal", "transactional", "category", "calculated", and "global". This parameter is mandatory.

    .PARAMETER Name
    Specifies the name of the attribute. This parameter is mandatory.

    .PARAMETER value
    Specifies the value of the attribute. Use only if the attribute's category is 'calculated' or 'global'. This parameter is optional.

    .PARAMETER isRecurring
    Specifies whether the attribute is recurring. Use only if the attribute's category is 'calculated' or 'global'. This parameter is optional.

    .PARAMETER enumeration
    Specifies a list of values and labels that the attribute can take. Use only if the attribute's category is 'category'. This parameter is optional.

    .PARAMETER multiCategoryOptions
    Specifies a list of options you want to add for a multiple-choice attribute. Use only if the attribute's category is 'normal' and the attribute's type is 'multiple-choice'. This parameter is optional.

    .PARAMETER type
    Specifies the type of the attribute. Valid values are "text", "date", "float", "boolean", "multiple-choice", "id", and "category". The default value is "text". This parameter is optional.
    
    .EXAMPLE
    PS C:\> New-BrevoContactAttribute -Category "normal" -Name "FirstName" -type "text"
    
    Creates a new contact attribute with the category "normal", name "FirstName", and type "text".
    
    .EXAMPLE
    PS C:\> New-BrevoContactAttribute -Category "category" -Name "Status" -enumeration @{"Active"="1"; "Inactive"="0"}
    
    Creates a new contact attribute with the category "category", name "Status", and an enumeration of values.

    .EXAMPLE
    PS C:\> New-BrevoContactAttribute -Category normal -Name "TAGS" -type multiple-choice -multiCategoryOptions @("Option1", "Option2", "Option3")
    
    Creates a new multiple-choice contact attribute with the category "normal", name "TAGS", type "multiple-choice", and specified options.
    
    .OUTPUTS
    Returns the created attribute object.
    
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "Category of the attribute")]
        [ValidateSet("normal", "transactional", "category", "calculated", "global")]
        [Alias ("attributeCategory")]
        $Category,

        [Parameter(Mandatory = $true, HelpMessage = "The name of the attribute")]
        [Alias ("attributeName")]
        $Name,

        [Parameter(Mandatory = $false, HelpMessage = "Value of the attribute. Use only if the attribute's category is 'calculated' or 'global'")]
        [ValidateSet("calculated", "global")]
        $value,

        [Parameter(Mandatory = $false, HelpMessage = "Type of the attribute. Use only if the attribute's category is 'calculated' or 'global'")]
        [ValidateSet("calculated", "global")]
        $isRecurring,
            
        [Parameter(Mandatory = $false, HelpMessage = "List of values and labels that the attribute can take. Use only if the attribute's category is 'category'")]
        $enumeration,

        [Parameter(Mandatory = $false, HelpMessage = "List of options you want to add for multiple-choice attribute. Use only if the attribute's category is 'normal' and attribute's type is 'multiple-choice'. e.g. @('Option1', 'Option2')")]
        $multiCategoryOptions,

        [Parameter(Mandatory = $false, HelpMessage = "Type of the attribute. Use only if the attribute's category is 'normal', 'category' or 'transactional'
Type boolean and multiple-choice is only available if the category is normal attribute Type id is only available if the category is transactional attribute
Type category is only available if the category is category attribute")]
        [ValidateSet("text", "date", "float", "boolean", "multiple-choice", "id", "category")]
        $type = "text"

    )
    $uri = "/contacts/attributes" + "/" + $Category + "/" + $Name
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
    try {
        $attribute = Invoke-BrevoCall @Params
        $attribute = Get-BrevoContactAttribute -Name $Name
    }
    catch {
    }
    return $attribute
}
