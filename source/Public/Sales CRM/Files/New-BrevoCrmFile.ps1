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

    if ([string]::IsNullOrEmpty($script:APIuri))
    {
        throw "Please connect first to the Brevo API using Connect-Brevo"
    }

    $urifull = $script:APIuri.TrimEnd('/') + "/crm/files"

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

    $headers = @{
        "api-key" = $script:APIkey.GetNetworkCredential().Password
        "Accept"  = "application/json"
    }

    try
    {
        Invoke-RestMethod -Uri $urifull -Method POST -Form $form -Headers $headers -ErrorAction Stop
    }
    catch
    {
        $e = $_ -replace '(\r\n|\n|\r)+', ''
        $e = $e.Replace([Environment]::NewLine, ' ')
        Write-Error $e
    }
}
