## Disable all mailbox IMAP
Get-Mailbox | Set-CASMailbox -imapenabled $false