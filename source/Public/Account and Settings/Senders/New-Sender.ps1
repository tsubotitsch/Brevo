function New-Sender {
    <#
    .SYNOPSIS
    Create a new sender domain in Brevo.

    .DESCRIPTION
    The New-Sender function sends a POST request to the Brevo API to create a new sender domain. 
    It uses the Invoke-BrevoCall function to perform the API call.

    .PARAMETERS
    -Email: The email address of the sender.
    -Name: The name of the sender.
    -ReplyTo: The reply-to email address for the sender.
    -ReturnPath: The return path email address for the sender.
    -Domain: The domain of the sender.
    -UpdateEnabled: Set this field to update the existing sender in the same request. Default is false.

    .OUTPUTS
    Returns the response from the Brevo API containing information about the created sender domain.

    .EXAMPLE
    PS> New-Sender -Email "
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "The email address of the sender")]
        [string]$Email,
        [Parameter(Mandatory = $true, HelpMessage = "The name of the sender")]
        [string]$Name,
        [Parameter(Mandatory = $false, HelpMessage = "array of objects. Mandatory in case of dedicated IP. IPs to associate to the sender. For example: @(
    @{ip = ""x.x.x.x""; domain = ""mydomain.com"";weight = 1})")]
        $ips
    )
    $params = @{
        "URI"          = "/senders"
        "Method"       = "POST"
    } 

    $params["Body"] = @{
        "email"       = $Email
        "name"        = $Name
    }
    if ($ips) {
        if ($ips -is [array]) {
            $params["Body"]["ips"] = $ips
        } else {
            throw "The 'ips' parameter must be an array of objects."
        }
    }

    $Sender = Invoke-BrevoCall @params
    return $Sender
}
