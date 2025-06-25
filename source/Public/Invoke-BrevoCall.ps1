
function Invoke-BrevoCall {
    <#
    .SYNOPSIS
        Makes API calls to the Brevo API.
    
    .DESCRIPTION
        This function is used to interact with the Brevo API by making RESTful API calls. 
        It supports various HTTP methods, handles pagination, and allows for flexible API interactions.
    
    .PARAMETER uri
        The relative URI of the API endpoint. This should be relative to the base URI provided in Connect-Brevo.
    
    .PARAMETER method
        The HTTP method to use for the API call. Supported methods are GET, POST, PUT, DELETE, and PATCH.
        Default: GET.
    
    .PARAMETER body
        The request body for methods like POST or PUT. This should be a PowerShell object that will be converted to JSON.
    
    .PARAMETER limit
        The number of results returned per page. The default and maximum value may vary per API.
    
    .PARAMETER offset
        The index of the first document in the page (starting with 0). For example, if the limit is 50 and you want to retrieve page 2, set offset to 50.
        Default: 0.
    
    .PARAMETER returnobject
        Specifies a specific object to return from the API response. If not specified, the full response will be returned.
    
    .EXAMPLE
        # Example: Retrieve a list of contacts with pagination
        Invoke-BrevoCall -uri "/contacts" -method "GET" -limit 50 -offset 0
    
    .EXAMPLE
        # Example: Create a new contact
        $body = @{
            email = "test@example.com"
            attributes = @{
                FNAME = "John"
                LNAME = "Doe"
            }
            listIds = @(1, 2)
        }
        Invoke-BrevoCall -uri "/contacts" -method "POST" -body $body
    
    .NOTES
        - Requires the Connect-Brevo function to be called first to set up the base URI and API key.
        - Handles pagination automatically if the API response includes a "count" property.
    
    #>
    [CmdletBinding()]
    [Alias("Invoke-BrevoApiCall", "Invoke-BrevoRestMethod")]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "The URI of the API call. This should be the relative URI to the base URI provided in Connect-Brevo")]
        [string]$uri,
        [Parameter(Mandatory = $false, HelpMessage = "The HTTP method to use for the API call")]
        [ValidateSet("GET", "POST", "PUT", "DELETE", "PATCH") ]
        $method = "GET",
        [Parameter(ParameterSetName = "Body")]
        [System.Object]$body,
        [Parameter(HelpMessage = "The number of results returned per page. The default and maximum value may vary per API")]
        $limit,
        [Parameter(HelpMessage = "The index of the first document in the page (starting with 0). For example, if the limit is 50 and you want to retrieve the page 2, then offset=50")]
        $offset = 0,
        [Parameter(HelpMessage = "The object with should be returned, if empty the full response will be returned")]
        $returnobject
    )

    Write-Debug ($PsBoundParameters | Out-String)
    Write-Debug ($args | Out-String)

    if ([string]::IsNullOrEmpty($script:APIuri)) {
        throw "Please connect first to the Brevo API using Connect-Brevo"
    }
    if ($uri -notlike "$script:APIuri*") {
        Write-Debug "$($MyInvocation.MyCommand):relative path provided"
        $urifull = ($script:apiuri + $uri).TrimEnd('/')
        Write-Debug "$($MyInvocation.MyCommand):urifull: $urifull"
    }
    else {
        Write-Debug "$($MyInvocation.MyCommand):absolute path provided"
        $urifull = $uri
    }
    if ($limit) {
        $urifull += "?limit=$limit"
    }
    if ($offset -ne 0) {
        Write-Debug "$($MyInvocation.MyCommand):Offset: $offset"
        if (-not $urifull.Contains('?')) {
            Write-Debug "No ? in URI"
            $urifull += "?offset=$offset"
        }
        else {
            Write-Debug "$($MyInvocation.MyCommand):URI contains ?"
            $urifull += "&offset=$offset"
        }
    }
    Write-Debug "urifull: $urifull"
    $Params = @{
        "URI"    = $urifull
        Headers  = @{
            "api-key"      = $script:APIkey.GetNetworkCredential().Password
            "content-type" = "application/json"
            "Accept"       = "application/json"
        }
        "Method" = $method
    }
    if ($body) {
        $Params.Add("Body", ($body | ConvertTo-Json -EnumsAsStrings -Depth 20))
    }

    $result = $null
    try {
        Write-Debug "Offset: $offset"
        do {
            Write-Debug "URI: $($Params.URI)"
            $loop = $true
            $Error.clear()
            $content = Invoke-RestMethod @Params -ResponseHeadersVariable responseheaders -StatusCodeVariable StatusCodeVariable -ErrorAction Stop
            Write-Debug ""
            Write-Debug "PropertyCount: $(($content.PSObject.Properties| Tee-Object -Variable Name | Measure-Object).count)"
            Write-Debug "Content: $($content |Select-Object * | Out-String)"
            Write-Debug "Property Count: $($content.count)"
            if ((($content.PSObject.Properties | Tee-Object -Variable name | Measure-Object).count -eq 2) -and ($content.PSObject.Properties.Name -contains "Count")) {
                $Property = ($content.PSObject.Properties | Where-Object { $_.Name -ne 'count' }).name
                $offset = $offset + ($content.$Property).count
                $result = $result + $content.$Property
                Write-Debug "Offset: $offset"

                #TODO: limit auf 1000 setzten um nicht so of loopen zu müssen
                if ($Params.URI -notlike "*offset*") {
                    if ($Params.URI -notlike '*?*') {
                        $Params.URI += "?offset=$offset"
                    }
                    else {
                        $Params.URI += "?offset=$offset"
                    }
                }
                else {
                    $Params.URI = $Params.URI -replace "offset=\d+", "offset=$offset"
                }
            }
            else {
                $result = $content
                $loop = $false
                Write-Debug "No property count - ending loop"
                Write-Debug "result: $($result | Out-String)"
            }
        } while (($loop -eq $true) -and ($offset -lt $content.Count))
        
        # return $result
        if ($returnobject) {
            Write-Debug "Returnobject: $returnobject"
            return $result.$returnobject
        }
        else {
            Write-Debug "No returnobject specified"
            return $result
        }
    }
    catch {
        throw $_.Exception.Message
        # $e = Get-Error -Newest 1
        # if ($e.TargetObject.Message) {
        #     $e.TargetObject.Message | ConvertFrom-Json | Out-String | Write-Error
        # }
    }
}
