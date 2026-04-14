function Get-BrevoPipeline
{
    <#
    .SYNOPSIS
        Retrieves pipelines from Brevo CRM.

    .DESCRIPTION
        The Get-BrevoPipeline cmdlet retrieves pipelines and their stages from Brevo CRM. 
        You can retrieve a single pipeline by its ID or list all available pipelines.
        
        Note: The list endpoint (GET /crm/pipeline/details) is deprecated. Use the get by ID endpoint for the most current API behavior.

    .PARAMETER Id
        The ID of the specific pipeline to retrieve. If not specified, lists all pipelines.

    .EXAMPLE
        Get-BrevoPipeline

        Retrieves all available pipelines.

    .EXAMPLE
        Get-BrevoPipeline -Id "pipe123"

        Retrieves a single pipeline with ID pipe123.

    .LINK
        https://developers.brevo.com/reference/get-pipeline-details
    #>
    [CmdletBinding()]
    param (
        [Parameter()]
        [Alias("PipelineId")]
        [string]$Id
    )

    $uri = "/crm/pipeline/details"

    if ($PSBoundParameters.ContainsKey("Id"))
    {
        $uri += "/$Id"
    }

    $Params = @{
        "URI"    = $uri
        "Method" = "GET"
    }

    Invoke-BrevoCall @Params
}
