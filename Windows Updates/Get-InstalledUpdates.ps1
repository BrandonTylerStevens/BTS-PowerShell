#./scripts/WindowsUpdate/GetInstalledUpdates.ps1
$searcher = New-Object -ComObject "Microsoft.Update.Searcher"
#Force the search to search using Windows Update 0 would use the default configured on the computer 2 forces windows update
#http://msdn.microsoft.com/en-us/library/windows/desktop/aa387280(v=vs.85).aspx
$searcher.ServerSelection = 0
$SearchResults = $searcher.Search("IsInstalled=1 and Type='Software'")
$SearchResults.Updates | Select-Object -ExpandProperty title
