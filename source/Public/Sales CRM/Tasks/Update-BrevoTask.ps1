function Update-BrevoTask
{
    <#
    .SYNOPSIS
        Updates an existing task in Brevo CRM.

    .DESCRIPTION
        Updates the properties of a task identified by its ID.

    .PARAMETER Id
        The unique ID of the task to update. This parameter is mandatory.

    .PARAMETER Name
        The updated name of the task.

    .PARAMETER Description
        The updated description of the task.

    .PARAMETER DueDate
        The updated due date of the task.

    .PARAMETER Priority
        The updated priority.

    .PARAMETER Status
        The updated status.

    .PARAMETER AssignedToId
        The updated user ID for task assignment.

    .EXAMPLE
        Update-BrevoTask -Id "task123" -Name "Updated Task" -Status "Completed"

        Updates the name and status of a task.

    .LINK
        https://developers.brevo.com/reference/update-a-task
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [Alias("TaskId")]
        [string]$Id,

        [Parameter()]
        [string]$Name,

        [Parameter()]
        [string]$Description,

        [Parameter()]
        [string]$DueDate,

        [Parameter()]
        [string]$Priority,

        [Parameter()]
        [string]$Status,

        [Parameter()]
        [int]$AssignedToId
    )

    $uri = "/crm/tasks/$Id"

    $body = @{}

    if ($PSBoundParameters.ContainsKey("Name"))
    {
        $body.name = $Name
    }
    if ($PSBoundParameters.ContainsKey("Description"))
    {
        $body.description = $Description
    }
    if ($PSBoundParameters.ContainsKey("DueDate"))
    {
        $body.dueDate = $DueDate
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

    $Params = @{
        "URI"    = $uri
        "Method" = "PATCH"
        "Body"   = $body
    }

    Invoke-BrevoCall @Params
}
