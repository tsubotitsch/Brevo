function Invoke-BrevoCall {
    param (
        [string]$uri,
        [Parameter(Mandatory = $false, HelpMessage = "The HTTP method to use for the API call")]
        [ValidateSet("GET", "POST", "PUT", "DELETE", "PATCH") ]
        $method = "GET",
        [Parameter(ParameterSetName = "Body")]
        [System.Object]$body,
        [Parameter(HelpMessage = "The number of results returned per page. The default and maximum value may vary per API")]
        $limit,
        [Parameter(HelpMessage = "The index of the first document in the page (starting with 0). For example, if the limit is 50 and you want to retrieve the page 2, then offset=50")]
        $offset = 0
    )
    
    if ($uri -notlike "$script:APIuri*") {
        $urifull = $script:apiuri + $uri
    }
    if ($limit) {
        $urifull += "?limit=$limit"
    }
    if ($offset -ne 0) {
        Write-Debug "urifull: $urifull"
        if (-not $urifull.Contains('?')) {
            Write-Debug "No ? in URI"
            $urifull += "?offset=$offset"
        }
        else {
            Write-Debug "URI contains ?"
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
    #$Params | ConvertTo-Json -Depth 20 | Write-Debug
    try {
        $content = Invoke-RestMethod @Params -ResponseHeadersVariable $responseheaders -StatusCodeVariable $StatusCodeVariable -ErrorAction Stop
        #TODO: Pagination https://developers.brevo.com/docs/how-it-works#pagination
        if ($content) {
            Write-Debug "Content: $($content|Out-String)"
            Write-Debug "Uri: $uri"
            $key = $uri.Split('/')[-1]
            Write-Debug "Key: $key"
            if ($content.PSObject.Properties[$key]) {
                Write-Debug "Key $key exists in the content."
                return $content.$key
            }
            else {
                Write-Debug "Key $key does not exist in the content."
            }
        }
    }
    #TODO https://developers.brevo.com/docs/how-it-works#http-response-codes
    catch [Microsoft.PowerShell.Commands.HttpResponseException] {
        Write-Debug "Status Code: $StatusCode"
        Write-Debug "Response Headers: $($responseheaders|Out-String)"
        Write-Debug "Error: $($_|Out-String)"
        $message = ($_.Errordetails.message | ConvertFrom-Json)
        $e = @{
            Status     = $message.status
            Code       = $message.code
            Message    = $message.message
            Command    = $_.InvocationInfo.MyCommand
            Method     = $_.TargetObject.Method
            RequestUri = $_.TargetObject.RequestUri
            Headers    = $_.TargetObject.Headers
        }
        switch -wildcard ($e.Status) {
            400 {
                Write-Error "HTTP error 400: $($message.code) - $($message.message)" -TargetObject $e -Category InvalidData        
            }
            401 {
                Write-Error "HTTP error 401: $($message.code) - $($message.message)" -TargetObject $e -Category AuthenticationError
            }
            403 {
                Write-Error "HTTP error 403: $($message.code) - $($message.message)" -TargetObject $e -Category AuthorizationError
            }
            404 {
                Write-Error "HTTP error 404: $($message.code) - $($message.message)" -TargetObject $e -Category ObjectNotFound
            }
        }
    }
}