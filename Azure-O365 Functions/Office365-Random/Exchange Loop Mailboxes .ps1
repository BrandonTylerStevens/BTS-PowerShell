$mailboxes = Get-Mailbox -ResultSize unlimited
foreach ($mailbox in $mailboxes)
{
    Write-Host "Mailbox = ", $mailbox.primarysmtpaddress
    Write-Host "Audited items = ", $mailbox.auditadmin
    Write-Host
}