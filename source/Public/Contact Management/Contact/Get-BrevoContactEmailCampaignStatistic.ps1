function Get-BrevoContactEmailCampaignStatistic
{
    <#
	.SYNOPSIS
	Retrieve email campaign statistics for a contact from Brevo.

	.DESCRIPTION
	The Get-BrevoContactEmailCampaignStatistic function fetches email campaign statistics
	for a given contact (by id or email) from the Brevo API. It forwards the request to
	`Invoke-BrevoCall` and returns the API result.

	.PARAMETER Id
	Contact identifier (contact_id, email_id or phone_id). Default parameter set.

	.PARAMETER Email
	Contact e-mail address. Use this parameter when you want to lookup by email.

	.PARAMETER Limit
	Number of items per page (optional).

	.PARAMETER Offset
	Offset for pagination (optional).

	.PARAMETER Sort
	Sort order: `asc` or `desc` (optional).

	.EXAMPLE
	PS C:\> Get-BrevoContactEmailCampaignStatistic -Id 12345

	Retrieve email campaign statistics for contact with id 12345.

	.EXAMPLE
	PS C:\> Get-BrevoContactEmailCampaignStatistic -Email "test@example.com" -Limit 10 -Offset 0

	Retrieve first page (10 items) of campaign statistics for the given email.

	.OUTPUTS
	Returns the API response object with campaign statistics.
	#>
    [CmdletBinding(DefaultParameterSetName = 'Id')]
    param (
        [Parameter(Mandatory = $false, ParameterSetName = 'Id', HelpMessage = 'Contact id (contact_id, email_id or phone_id)')]
        [string]$Id,

        [Parameter(Mandatory = $false, ParameterSetName = 'Email', HelpMessage = 'Contact email address')]
        [string]$Email,

        [Parameter(Mandatory = $false)]
        [int]$Limit,

        [Parameter(Mandatory = $false)]
        [int]$Offset,

        [Parameter(Mandatory = $false)]
        [ValidateSet('asc', 'desc')]
        [string]$Sort
    )

    begin
    {
        # Build base URI according to parameter set
        if ($PSCmdlet.ParameterSetName -eq 'Id' -and -not [string]::IsNullOrEmpty($Id))
        {
            $baseUri = "/contacts/$Id/emailCampaigns"
        }
        elseif ($PSCmdlet.ParameterSetName -eq 'Email' -and -not [string]::IsNullOrEmpty($Email))
        {
            $escaped = [System.Web.HttpUtility]::UrlEncode($Email)
            $baseUri = "/contacts/$escaped/emailCampaigns"
        }
        else
        {
            Write-Error 'Either -Id or -Email must be provided.'
            return $null
        }

        $queryParams = @{}
        if ($PSBoundParameters.ContainsKey('Limit'))
        {
            $queryParams['limit'] = $Limit 
        }
        if ($PSBoundParameters.ContainsKey('Offset'))
        {
            $queryParams['offset'] = $Offset 
        }
        if ($PSBoundParameters.ContainsKey('Sort'))
        {
            $queryParams['sort'] = $Sort 
        }

        if ($queryParams.Count -gt 0)
        {
            $queryString = ($queryParams.GetEnumerator() | ForEach-Object { "{0}={1}" -f $_.Key, $_.Value }) -join '&'
            $uri = "$baseUri?$queryString"
        }
        else
        {
            $uri = $baseUri
        }

        $Params = @{ URI = $uri; Method = 'GET' }
    }

    process
    {
        try
        {
            $result = Invoke-BrevoCall @Params
            return $result
        }
        catch
        {
            Write-Error $_.Exception.Message
            return $null
        }
    }
}
