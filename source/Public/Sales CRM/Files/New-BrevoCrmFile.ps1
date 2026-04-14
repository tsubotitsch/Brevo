function New-BrevoCrmFile
{
    <#
    .SYNOPSIS
        Uploads a new file to Brevo CRM.

    .DESCRIPTION
        The New-BrevoCrmFile cmdlet uploads a new file to Brevo CRM using multipart form data.

    .PARAMETER FilePath
        The local path to the file to upload. This parameter is mandatory.

    .PARAMETER LinkedDealIds
        An array of deal IDs to link to the file.

    .PARAMETER LinkedContactIds
        An array of contact IDs to link to the file.

    .PARAMETER LinkedCompanyIds
        An array of company IDs to link to the file.

    .EXAMPLE
        New-BrevoCrmFile -FilePath "C:\documents\contract.pdf"

        Uploads a PDF file to Brevo CRM.

    .EXAMPLE
        New-BrevoCrmFile -FilePath "C:\documents\contract.pdf" -LinkedDealIds @("deal1")

        Uploads a file and links it to a specific deal.

    .LINK
        https://developers.brevo.com/reference/upload-a-file
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, HelpMessage = "Path to the file to upload")]
        [ValidateScript({ Test-Path $_ })]
        [string]$FilePath,

        [Parameter()]
        [string[]]$LinkedDealIds,

        [Parameter()]
        [int[]]$LinkedContactIds,

        [Parameter()]
        [string[]]$LinkedCompanyIds
    )

    $form = @{
        file = Get-Item -LiteralPath $FilePath
    }

    if ($PSBoundParameters.ContainsKey("LinkedDealIds"))
    {
        $form.linkedDealIds = $LinkedDealIds
    }
    if ($PSBoundParameters.ContainsKey("LinkedContactIds"))
    {
        $form.linkedContactIds = $LinkedContactIds
    }
    if ($PSBoundParameters.ContainsKey("LinkedCompanyIds"))
    {
        $form.linkedCompanyIds = $LinkedCompanyIds
    }

    $Params = @{
        URI    = "/crm/files"
        Method = "POST"
        Form   = $form
    }

    Invoke-BrevoCall @Params
}
