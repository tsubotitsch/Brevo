function New-BrevoDeal
{
    <#
    .SYNOPSIS
        Creates a new deal in Brevo CRM.

    .DESCRIPTION
        The New-BrevoDeal cmdlet creates a new deal in Brevo CRM.

    .PARAMETER Title
        The title of the deal. This parameter is mandatory.

    .PARAMETER Value
        The monetary value of the deal.

    .PARAMETER Currency
        The currency of the deal value (e.g., "USD", "EUR").

    .PARAMETER Status
        The status of the deal.

    .PARAMETER PipelineId
        The ID of the pipeline this deal belongs to.

    .PARAMETER StageId
        The ID of the stage within the pipeline.

    .PARAMETER ExpectedCloseDate
        The expected close date of the deal. Accepts any value parseable as a DateTime; sent to the API as ISO 8601.

    .PARAMETER ProbabilityPercentage
        The probability of winning the deal (0-100).

    .PARAMETER LinkedContactIds
        An array of contact IDs to link to the deal.

    .PARAMETER LinkedCompanyIds
        An array of company IDs to link to the deal.

    .EXAMPLE
        New-BrevoDeal -Title "Enterprise Deal" -Value 50000 -Currency "USD" -PipelineId "pipe1"

        Creates a new deal with a specific value and pipeline.

    .LINK
        https://developers.brevo.com/reference/create-a-deal
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, HelpMessage = "Deal title")]
        [ValidateNotNullOrEmpty()]
        [string]$Title,

        [Parameter()]
        [decimal]$Value,

        [Parameter()]
        [string]$Currency,

        [Parameter()]
        [string]$Status,

        [Parameter()]
        [string]$PipelineId,

        [Parameter()]
        [string]$StageId,

        [Parameter()]
        [DateTime]$ExpectedCloseDate,

        [Parameter()]
        [ValidateRange(0, 100)]
        [int]$ProbabilityPercentage,

        [Parameter()]
        [int[]]$LinkedContactIds,

        [Parameter()]
        [string[]]$LinkedCompanyIds
    )

    $uri = "/crm/deals"

    $body = @{
        title = $Title
    }

    if ($PSBoundParameters.ContainsKey("Value"))
    {
        $body.value = $Value
    }
    if ($PSBoundParameters.ContainsKey("Currency"))
    {
        $body.currency = $Currency
    }
    if ($PSBoundParameters.ContainsKey("Status"))
    {
        $body.status = $Status
    }
    if ($PSBoundParameters.ContainsKey("PipelineId"))
    {
        $body.pipelineId = $PipelineId
    }
    if ($PSBoundParameters.ContainsKey("StageId"))
    {
        $body.stageId = $StageId
    }
    if ($PSBoundParameters.ContainsKey("ExpectedCloseDate"))
    {
        $body.expectedCloseDate = $ExpectedCloseDate.ToUniversalTime().ToString("o")
    }
    if ($PSBoundParameters.ContainsKey("ProbabilityPercentage"))
    {
        $body.probabilityPercentage = $ProbabilityPercentage
    }
    if ($PSBoundParameters.ContainsKey("LinkedContactIds"))
    {
        $body.linkedContactIds = $LinkedContactIds
    }
    if ($PSBoundParameters.ContainsKey("LinkedCompanyIds"))
    {
        $body.linkedCompanyIds = $LinkedCompanyIds
    }

    $Params = @{
        "URI"    = $uri
        "Method" = "POST"
        "Body"   = $body
    }

    Invoke-BrevoCall @Params
}
