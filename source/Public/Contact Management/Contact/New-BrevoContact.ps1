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

    .EXAMPLE
    PS> New-BrevoContact -Email "example@example.com" -ListIds 1,2 -Attributes @{"FIRSTNAME"="John"; "LASTNAME"="Doe"} -updateEnabled

    This example demonstrates creating a single contact with mandatory and optional parameters.

    .EXAMPLE
    PS> @(
    @{ Email = "example1@example.com"; ListIds = @(1, 2); Attributes = @{"FIRSTNAME"="John"; "LASTNAME"="Doe"} },
    @{ Email = "example2@example.com"; ListIds = @(3, 4); Attributes = @{"FIRSTNAME"="Jane"; "LASTNAME"="Smith"} }
    ) | New-BrevoContact

    This example demonstrates creating multiple contacts by passing them over the pipeline.
    
    .OUTPUTS
    The id of the created contact.
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "The email address of the contact", ValueFromPipelineByPropertyName = $true, ValueFromPipeline = $true)]
        [string]$Email,
        [Parameter(Mandatory = $false, HelpMessage = "Pass your own Id to create a contact.", ValueFromPipelineByPropertyName = $true)]
        [string]$ext_id,

        [Parameter(Mandatory = $false, HelpMessage = "The IDs of the contact list to which the contact is added", ValueFromPipelineByPropertyName = $true)]
        [int[]]$ListIds,
        [Parameter(Mandatory = $false, HelpMessage = 'Pass the set of attributes and their values. The attributes parameter should be passed in capital letter while creating a contact. Values that dont match the attribute type (e.g. text or string in a date attribute) will be ignored. These attributes must be present in your Brevo account. For e.g. -Attributes @{"FIRSTNAME"="John"; "LASTNAME"="Doe"}', ValueFromPipelineByPropertyName = $true)]
        $attributes,
        [Parameter(Mandatory = $false, HelpMessage = "Set this field to blacklist the contact for emails", ValueFromPipelineByPropertyName = $true)]
        [switch]$emailBlacklisted,
        [Parameter(Mandatory = $false, HelpMessage = "Set this field to blacklist the contact for SMS", ValueFromPipelineByPropertyName = $true)]
        [switch]$smsBlacklisted,
        [Parameter(Mandatory = $false, HelpMessage = "Facilitate to update the existing contact in the same request. Default is false.", ValueFromPipelineByPropertyName = $true)]
        [switch]$updateEnabled = $false,
        [Parameter(Mandatory = $false, HelpMessage = "transactional email forbidden sender for contact. Use only for email Contact ( only available if updateEnabled = true )", ValueFromPipelineByPropertyName = $true)]
        [string[]]$smtpBlacklistSender
    )

    begin {
        $contacts = @()
    }

    process {
        $contacts += [PSCustomObject]@{
            Email = $Email
            ext_id = $ext_id
            ListIds = $ListIds
            attributes = $attributes
            emailBlacklisted = $emailBlacklisted
            smsBlacklisted = $smsBlacklisted
            updateEnabled = $updateEnabled
            smtpBlacklistSender = $smtpBlacklistSender
        }
    }

    end {
        foreach ($contact in $contacts) {
            $uri = "/contacts"
            $method = "POST"

            $body = @{ email = $contact.Email }

            if ($contact.ListIds) {
                $body.listIds = $contact.ListIds
            }

            if ($contact.ext_id) {
                $body.ext_id = $contact.ext_id
            }

            if ($contact.attributes) {
                $attrib = @{}
                if ($contact.attributes -is [hashtable]) {
                    $contact.attributes.GetEnumerator() | ForEach-Object {
                        $attrib.Add($_.Key, $_.Value)
                    }
                } else {
                    Write-Error "The 'attributes' parameter must be a hashtable."
                }
                $body.attributes = $attrib
            }

            $Params = @{ "URI" = $uri; "Method" = $method; "Body" = $body }
            $result = Invoke-BrevoCall @Params
            Write-Output $result
        }
    }

}
