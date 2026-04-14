function New-BrevoTask
{
    <#
    .SYNOPSIS
        Creates a new task in Brevo CRM.

    .DESCRIPTION
        The New-BrevoTask cmdlet creates a new task in Brevo CRM.

    .PARAMETER Name
        The name of the task. This parameter is mandatory.

    .PARAMETER Description
        The description of the task.

    .PARAMETER DueDate
        The due date for the task. Accepts any value parseable as a DateTime; sent to the API as ISO 8601.

    .PARAMETER Priority
        The priority of the task.

    .PARAMETER Status
        The current status of the task.

    .PARAMETER AssignedToId
        The user ID of the person this task is assigned to.

    .PARAMETER LinkedContactIds
        An array of contact IDs to link to the task.

    .PARAMETER LinkedDealIds
        An array of deal IDs to link to the task.

    .PARAMETER LinkedCompanyIds
        An array of company IDs to link to the task.

    .EXAMPLE
        New-BrevoTask -Name "Follow up call" -DueDate "2024-12-31" -Priority "High"

        Creates a new task with a due date and priority.

    .LINK
        https://developers.brevo.com/reference/create-a-task
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, HelpMessage = "Task name")]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [Parameter()]
        [string]$Description,

        [Parameter()]
        [DateTime]$DueDate,

        [Parameter()]
        [string]$Priority,

        [Parameter()]
        [string]$Status,

        [Parameter()]
        [int]$AssignedToId,

        [Parameter()]
        [int[]]$LinkedContactIds,

        [Parameter()]
        [string[]]$LinkedDealIds,

        [Parameter()]
        [string[]]$LinkedCompanyIds
    )

    $uri = "/crm/tasks"

    $body = @{
        name = $Name
    }

    if ($PSBoundParameters.ContainsKey("Description"))
    {
        $body.description = $Description
    }
    if ($PSBoundParameters.ContainsKey("DueDate"))
    {
        $body.dueDate = $DueDate.ToUniversalTime().ToString("o")
    }
    if ($PSBoundParameters.ContainsKey("Priority"))
    {
        $body.priority = $Priority
    }
    if ($PSBoundParameters.ContainsKey("Status"))
    {
        $body.status = $Status
    }
    if ($PSBoundParameters.ContainsKey("AssignedToId"))
    {
        $body.assignedToId = $AssignedToId
    }
    if ($PSBoundParameters.ContainsKey("LinkedContactIds"))
    {
        $body.linkedContactIds = $LinkedContactIds
    }
    if ($PSBoundParameters.ContainsKey("LinkedDealIds"))
    {
        $body.linkedDealIds = $LinkedDealIds
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
