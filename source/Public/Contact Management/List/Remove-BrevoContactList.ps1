function Remove-BrevoContactList {
    <#
    .SYNOPSIS
    Removes a contact list by its ID.

    .DESCRIPTION
    The Remove-BrevoContactList function deletes a contact list identified by its unique ID. 
    It sends a DELETE request to the specified URI endpoint.

    .PARAMETER listId
    The ID of the contact list to delete. This parameter is mandatory.

    .EXAMPLE
    Remove-BrevoContactList -listId 12345

    .EXAMPLE
    PS> @(12345, 67890) | Remove-BrevoContactList

    This example demonstrates deleting multiple contact lists by passing their IDs through the pipeline.

    This command deletes the contact list with the ID 12345.
    
    #>
    [CmdletBinding(ConfirmImpact = 'High', SupportsShouldProcess = $true)]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "The ID of the contact list to delete", ValueFromPipelineByPropertyName = $true, ValueFromPipeline = $true)]
        [int]$listId
    )
    begin{
        $method = "DELETE"
    }

    process {
        $uri = "/contacts/lists/$listId"

        $Params = @{ "URI" = $uri; "Method" = $method }
        if($PSCmdlet.ShouldProcess("$listId", "Remove-BrevoContactList")) {
            $list = Invoke-BrevoCall @Params
            Write-Information "Removed contact list with ID: $listId"
            return $list
        }
    }
}
