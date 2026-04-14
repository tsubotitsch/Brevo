function Update-BrevoDeal
{
    <#
    .SYNOPSIS
        Updates an existing deal in Brevo CRM.

    .DESCRIPTION
        Updates the properties of a deal identified by its ID.

    .PARAMETER Id
        The unique ID of the deal to update. This parameter is mandatory.

    .PARAMETER Title
        The updated title of the deal.

    .PARAMETER Value
        The updated value of the deal.

    .PARAMETER Currency
        The updated currency.

    .PARAMETER Status
        The updated status of the deal.

    .PARAMETER StageId
        The updated stage ID.

    .PARAMETER ExpectedCloseDate
        The updated expected close date. Accepts any value parseable as a DateTime; sent to the API as ISO 8601.

    .PARAMETER ProbabilityPercentage
        The updated probability percentage (0-100).

    .EXAMPLE
        Update-BrevoDeal -Id "deal123" -Title "Updated Deal" -Value 75000

        Updates the title and value of a deal.

    .LINK
        https://developers.brevo.com/reference/update-a-deal
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [Alias("DealId")]
        [string]$Id,

        [Parameter()]
        [string]$Title,

        [Parameter()]
        [decimal]$Value,

        [Parameter()]
        [string]$Currency,

        [Parameter()]
        [string]$Status,

        [Parameter()]
        [string]$StageId,

        [Parameter()]
        [DateTime]$ExpectedCloseDate,

        [Parameter()]
        [ValidateRange(0, 100)]
        [int]$ProbabilityPercentage
    )

    $uri = "/crm/deals/$Id"

    $body = @{}

    if ($PSBoundParameters.ContainsKey("Title"))
    {
        $body.title = $Title
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

    $Params = @{
        "URI"    = $uri
        "Method" = "PATCH"
        "Body"   = $body
    }

    Invoke-BrevoCall @Params
}
