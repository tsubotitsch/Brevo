function Remove-BrevoContactAttributeMultipleChoiceOption
{
    <#
    .SYNOPSIS
    Remove one or more options from a multiple-choice contact attribute in Brevo.

    .DESCRIPTION
    The Remove-BrevoContactAttributeMultipleChoiceOption function deletes specified options
    from a multiple-choice contact attribute. Provide option values
    as represented in your installation. The function sends a
    DELETE request to the Brevo API endpoint for multi-choice options.

    .PARAMETER Name
    Name of the existing attribute (case-insensitive).

    .PARAMETER Option
    Option value to remove. Can be a single value or an array of values.

    .EXAMPLE
    PS C:\> Remove-BrevoContactAttributeMultipleChoiceOption -Name Tags -Option 123

    Removes option 123 from the "Tags" multiple-choice attribute.

    .EXAMPLE
    PS C:\> Remove-BrevoContactAttributeMultipleChoiceOption -Name Tags -Option "OptA","OptB"

    Removes options with values "OptA" and "OptB" from the "Tags" attribute.

    .OUTPUTS
    Returns $true on success, $null on failure.
    #>

    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    param (
        [Parameter(Mandatory = $true, HelpMessage = 'Name of the existing multiple-choice attribute')]
        [Alias('attributeName')]
        [string]$Name,

        [Parameter(Mandatory = $true, HelpMessage = 'The existing multiple-choice attribute option that you want to delete')]
        [Alias('OptionName')]
        $Option
    )

    begin
    {
        $Name = $Name.ToUpper()
    }
    process
    {
        $results = @()
        foreach ($opt in $Option)
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
