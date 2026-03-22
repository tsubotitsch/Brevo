function Remove-BrevoContactAttributeMultipleChoiceOption
{
    <#
    .SYNOPSIS
    Remove one or more options from a multiple-choice contact attribute in Brevo.

    .DESCRIPTION
    The Remove-BrevoContactAttributeMultipleChoiceOption function deletes specified options
    from a multiple-choice contact attribute. Provide option identifiers or option values
    depending on how options are represented in your installation. The function sends a
    DELETE request to the Brevo API endpoint for multi-choice options.

    .PARAMETER Category
    Attribute category. Valid values: "normal", "transactional", "category", "calculated", "global".

    .PARAMETER Name
    Name of the existing attribute (case-insensitive).

    .PARAMETER OptionIds
    Array of option ids to remove (preferred if options have numeric ids).

    .PARAMETER Options
    Array of option values to remove (use if options are identified by their value).

    .EXAMPLE
    PS C:\> Remove-BrevoContactAttributeMultipleChoiceOption -Category normal -Name Tags -OptionIds 123,124

    Removes options with ids 123 and 124 from the "Tags" multiple-choice attribute.

    .EXAMPLE
    PS C:\> Remove-BrevoContactAttributeMultipleChoiceOption -Category normal -Name Tags -Options "OptA","OptB"

    Removes options with values "OptA" and "OptB" from the "Tags" attribute.

    .OUTPUTS
    Returns $true on success, $null on failure.
    #>

    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    param (
        [Parameter(Mandatory = $true, HelpMessage = 'Name of the existing multiple-choice attribute')]
        [Alias('attributeName')]
        [string]$Name,

        [Parameter(Mandatory = $true, HelpMessage = 'Name of the existing multiple-choice attribute option that you want to delete')]
        $OptionName
    )

    begin
    {
        $Name = $Name.ToUpper()
    }
    process
    {
        $results = @()
        foreach ($opt in $OptionName)
        {
            if ($PSCmdlet.ShouldProcess("multiple-choice/$Name - option $opt", 'Remove option'))
            {
                $params = @{ 
                    URI    = "/contacts/attributes/multiple-choice/$Name/$([System.Uri]::EscapeDataString($opt))"
                    Method = 'DELETE' 
                }
                try
                {
                    $res = Invoke-BrevoCall @params
                    $results += $res
                }
                catch
                {
                    Write-Error $_.Exception.Message
                    if ($PSCmdlet.ParameterSetName -ne 'IgnoreErrors')
                    {
                        continue 
                    } 
                }
            }
        }
        return $results
    }
}
