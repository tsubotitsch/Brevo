# function Send-UserInvitation {
#     [CmdletBinding()]   
#     param(
#         [Parameter(Mandatory = $true, HelpMessage = "Email address for the organization")]
#         [string]$email,
#         [Parameter(Mandatory = $true, HelpMessage = "All access to the features")]
#         [bool]$all_features_access
#         # [Parameter(Mandatory = $true, HelpMessage = "Privileges for the user. See https://developers.brevo.com/reference/inviteuser for reference")]
#         # [ValidateSet(
#         #     "email_campaigns_create_edit_delete",
#         #     "email_campaigns_send_schedule_suspend",
#         #     "sms_campaigns_create_edit_delete",
#         #     "sms_campaigns_send_schedule_suspend",
#         #     "contacts_view",
#         #     "contacts_create_edit_delete",
#         #     "contacts_import",
#         #     "contacts_export",
#         #     "contacts_list_and_attributes",
#         #     "contacts_forms",
#         #     "templates_create_edit_delete",
#         #     "templates_activate_deactivate",
#         #     "workflows_create_edit_delete",
#         #     "workflows_activate_deactivate_pause",
#         #     "workflows_settings",
#         #     "facebook_ads_create_edit_delete",
#         #     "facebook_ads_schedule_pause",
#         #     "landing_pages_all",
#         #     "transactional_emails_settings",
#         #     "transactional_emails_logs",
#         #     "smtp_api_smtp",
#         #     "smtp_api_api_keys",
#         #     "smtp_api_authorized_ips",
#         #     "user_management_all",
#         #     "sales_platform_create_edit_deals",
#         #     "sales_platform_delete_deals",
#         #     "sales_platform_manage_others_deals_tasks",
#         #     "sales_platform_reports",
#         #     "sales_platform_settings",
#         #     "phone_all",
#         #     "conversations_access",
#         #     "conversations_assign",
#         #     "conversations_configure",
#         #     "senders_domains_dedicated_ips_senders_management",
#         #     "senders_domains_dedicated_ips_domains_management",
#         #     "senders_domains_dedicated_ips_dedicated_ips_management",
#         #     "push_notifications_view",
#         #     "push_notifications_create_edit_delete",
#         #     "push_notifications_send",
#         #     "push_notifications_settings",
#         #     "companies_manage_owned_companies",
#         #     "companies_manage_other_companies",
#         #     "companies_settings"
#         # )]
#         # [string[]]$privileges

#         #TODO

#     )
#     $body = @{
#         "email"               = $email
#         "all_features_access" = $all_features_access
#         "privileges"          = $privileges
#     }

#     $uri = "https://api.sendinblue.com/v3/users/$userId/invite"   
#     $Params = @{
#         "URI"    = $uri
#         "Method" = "POST"
#         "Body"   = $body
#     }
#     $userInvitation = Invoke-BrevoCall @Params
#     return $userInvitation
# }