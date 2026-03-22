function New-BrevoContact 
{
    <#
    .SYNOPSIS
    Creates a new contact in Brevo with the specified details.
    
    .DESCRIPTION
    The `New-BrevoContact` function allows you to create a new contact in Brevo by providing details such as email, list IDs, attributes, and other optional parameters. It supports updating an existing contact if the `-updateEnabled` switch is set.
    
    .PARAMETER Email
    The email address of the contact. This parameter is mandatory.
    
    .PARAMETER ext_id
    An optional external ID to associate with the contact.
    
    .PARAMETER ListIds
    The IDs of the contact list(s) to which the contact will be added. This parameter is optional.
    
    .PARAMETER attributes
    A hashtable containing attributes and their values for the contact. The attributes should be passed in uppercase letters. Ensure the attributes exist in your Brevo account. For example: `-attributes @{"FIRSTNAME"="John"; "LASTNAME"="Doe"}`.
    ATTENTION: multi-choice options must be available in Brevo before assigning them.

    .PARAMETER emailBlacklisted
    A switch to blacklist the contact for emails. This parameter is optional.
    
    .PARAMETER smsBlacklisted
    A switch to blacklist the contact for SMS. This parameter is optional.
    
    .PARAMETER updateEnabled
    A switch to enable updating an existing contact in the same request. Default is `$false`.
    
    .PARAMETER smtpBlacklistSender
    An array of transactional email forbidden senders for the contact. This is only applicable if `-updateEnabled:$true`.
    
    .EXAMPLE
    # Create a new contact with mandatory and optional parameters
    New-BrevoContact -Email "example@example.com" -ListIds 1,2 -Attributes @{"FIRSTNAME"="John"; "LASTNAME"="Doe"} -updateEnabled
    
    .OUTPUTS
    The id of the created contact.
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "The email address of the contact")]
        [string]$Email,
        [Parameter(Mandatory = $false, HelpMessage = "Pass your own Id to create a contact.")]
        [string]$ext_id,

        [Parameter(Mandatory = $false, HelpMessage = "The IDs of the contact list to which the contact is added")]
        [int[]]$ListIds,
        [Parameter(Mandatory = $false, HelpMessage = 'Pass the set of attributes and their values. The attributes parameter should be passed in capital letter while creating a contact. Values that dont match the attribute type (e.g. text or string in a date attribute) will be ignored. These attributes must be present in your Brevo account. For e.g. -Attributes @{"FIRSTNAME"="John"; "LASTNAME"="Doe"}')]
        $attributes,
        [Parameter(Mandatory = $false, HelpMessage = "Set this field to blacklist the contact for emails ")]
        [switch]$emailBlacklisted,
        [Parameter(Mandatory = $false, HelpMessage = "Set this field to blacklist the contact for SMS")]
        [switch]$smsBlacklisted,
        [Parameter(Mandatory = $false, HelpMessage = "Facilitate to update the existing contact in the same request. Default is false.")]
        [switch]$updateEnabled = $false,
        [Parameter(Mandatory = $false, HelpMessage = "Options to add for a multiple-choice attribute. Use only if the attribute's category is 'normal' and the attribute's type is 'multiple-choice'")]
        [switch]$CreateMultiChoiceOptions = $false,
        [Parameter(Mandatory = $false, HelpMessage = "transactional email forbidden sender for contact. Use only for email Contact ( only available if updateEnabled = true )")]
        [string[]]$smtpBlacklistSender

    )
    $uri = "/contacts"
    $method = "POST"
    
    $body = @{
        email = $Email
    }

    if ($ListIds) {
        $body.listIds = $ListIds
    }

    if ($ext_id) {
        $body.ext_id = $ext_id
    }
    if ($attributes) {
        $attrib = @{}
        if ($attributes -is [hashtable]) {
            $attributes.GetEnumerator() | ForEach-Object {
                $attrib.Add($_.Key.toupper(), $_.Value)
            }
        }
        else {
            Write-Error "The 'attributes' parameter must be a hashtable."
        }
        $body.attributes = $attrib
    }
    if ($emailBlacklisted.IsPresent) {
        $body.emailBlacklisted = $true
    }
    if ($smsBlacklisted.IsPresent) {
        $body.smsBlacklisted = $true
    }
    if ($updateEnabled.IsPresent) {
        $body.updateEnabled = $true
    }
    if ($smtpBlacklistSender) {
        $body.smtpBlacklistSender = $smtpBlacklistSender
    }
    if ($CreateMultiChoiceOptions) {
        Write-Host "Checking and adding multi-choice options if needed..." -ForegroundColor Magenta
        # get all existing multi-choice attributes
        Write-Debug "Checking for multi-choice attributes to add options..."
        $multiChoiceAttributes = Get-BrevoContactAttribute -Category normal -Type "multiple-choice"
        # check if one of the given $attributes is multi-choice
        foreach ($attrKey in $attributes.Keys) {
            $upperKey = $attrKey.ToUpper()
            $matchingAttr = $multiChoiceAttributes | Where-Object { $_.name -ieq $upperKey }
            if ($matchingAttr) {
                # add missing options
                $existingOptions = $matchingAttr.multiCategoryOptions
                Write-Host "Existing options for multi-choice attribute '$upperKey': $($existingOptions -join ', ')" -ForegroundColor Cyan
                $newOptions = @()
                foreach ($option in $attributes[$attrKey]) {
                    if ($existingOptions -notcontains $option) {
                        Write-Host "Option '$option' is missing in multi-choice attribute '$upperKey'. Adding it." -ForegroundColor Magenta
                        $newOptions += $option
                    }
                }
                if ($newOptions.Count -gt 0) {
                    Write-Debug "Adding new options to multi-choice attribute '$upperKey': $($newOptions -join ', ')"
                    New-BrevoContactAttributeMultipleChoiceOption -Category normal -Name $upperKey -Option $newOptions -errorAction Stop
                } else {
                    Write-Debug "No new options to add for multi-choice attribute '$upperKey'."
                }
            }
        }
    }

    $Params = @{
        "URI"          = $uri
        "Method"       = $method
        "Body"         = $body
        #"returnobject" = "contacts"
    }
    $contact = Invoke-BrevoCall @Params
    return $contact
}
