## Disable IMAP and POP3 for new users
Get-CASMailboxPlan | Set-CASMailboxPlan -imapenabled $false -PopEnabled $false