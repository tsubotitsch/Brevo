function New-BrevoSender {
    <#
    .SYNOPSIS
    Create a new sender domain in Brevo.

    .DESCRIPTION
    The New-BrevoSender function sends a POST request to the Brevo API to create a new sender domain. 
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
    PS> New-BrevoSender -Email "example@domain.com" -Name "Example Sender"

    This example demonstrates how to create a new sender with the email address "example@domain.com" and the name "Example Sender".

    .EXAMPLE
    PS> @{
    Email = "example@domain.com"
    Name = "Example Sender"
    } | New-BrevoSender

    This example demonstrates how to pass all parameters over the pipeline to create a new sender.

    .EXAMPLE
    PS> $ips = @(@{ip = "192.168.1.1"; domain = "example.com"; weight = 1})
    PS> @{
    Email = "example@domain.com"
    Name = "Example Sender"
    } | New-BrevoSender -ips $ips

    This example demonstrates how to pass the 'ips' parameter as a regular parameter while passing the rest of the parameters over the pipeline to create a new sender.

    .EXAMPLE
    PS> @(
    @{ Email = "example1@domain.com"; Name = "Example Sender 1" },
    @{ Email = "example2@domain.com"; Name = "Example Sender 2" }
    ) | New-BrevoSender

    This example demonstrates how to pass multiple sender objects over the pipeline to create multiple senders.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "The email address of the sender", ValueFromPipelineByPropertyName = $true)]
        [string]$Email,
        [Parameter(Mandatory = $true, HelpMessage = "The name of the sender", ValueFromPipelineByPropertyName = $true)]
        [string]$Name,
        [Parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true, HelpMessage = "array of objects. Mandatory in case of dedicated IP. IPs to associate to the sender. For example: @(
    @{ip = ""x.x.x.x""; domain = ""mydomain.com"";weight = 1})")]
        $ips
    )
    process{
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
    
        return Invoke-BrevoCall @params
    }

}
