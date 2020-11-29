## Disable all mailbox forwarding
Get-Mailbox | Set-Mailbox -ForwardingAddress $null
Get-Mailbox | Set-Mailbox -ForwardingSmtpAddress $null