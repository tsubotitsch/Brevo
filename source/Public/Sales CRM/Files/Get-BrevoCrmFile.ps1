function Get-BrevoCrmFile
{
    <#
    .SYNOPSIS
        Retrieves files from Brevo CRM.

    .DESCRIPTION
        The Get-BrevoCrmFile cmdlet retrieves files from Brevo CRM. You can retrieve a single file by its ID or list multiple files with optional pagination.

    .PARAMETER Id
        The ID of the specific file to retrieve. This parameter is mandatory when using the ById parameter set.

    .PARAMETER Limit
        The maximum number of files to return. Default is 50.

    .PARAMETER Offset
        The number of files to skip for pagination. Default is 0.

    .EXAMPLE
        Get-BrevoCrmFile -Id "file123"

        Retrieves a single file with ID file123.

    .EXAMPLE
        Get-BrevoCrmFile -Limit 10

        Retrieves the first 10 files.

    .LINK
        https://developers.brevo.com/reference/get-files

    .LINK
        https://developers.brevo.com/reference/get-a-file
    #>
    [CmdletBinding(DefaultParameterSetName = "List")]
    param (
        [Parameter(Mandatory, ParameterSetName = "ById")]
        [Alias("FileId")]
        [string]$Id,

        [Parameter(ParameterSetName = "List")]
        [long]$Limit = 50,

        [Parameter(ParameterSetName = "List")]
        [long]$Offset = 0
    )

    $uri = "/crm/files"
    switch ($PSCmdlet.ParameterSetName)
    {
        "ById"
        {
            $uri += "/$Id"
        }

        "List"
        {
            $queryParams = [System.Collections.Generic.List[string]]::new()

            if ($PSBoundParameters.ContainsKey("Limit"))
            {
                $queryParams.Add("limit=$Limit")
            }
            if ($PSBoundParameters.ContainsKey("Offset"))
            {
                $queryParams.Add("offset=$Offset")
            }

            if ($queryParams.Count -gt 0)
            {
                $uri += "?" + ($queryParams -join "&")
            }
        }
    }

    $Params = @{
        "URI"    = $uri
        "Method" = "GET"
    }

    Invoke-BrevoCall @Params
}
