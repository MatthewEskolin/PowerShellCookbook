Select-String -Path C:\Users\Matthew\Desktop\DesktopModules\* -Pattern 'administrator'


Get-ChildItem C:\DesktopModules\* -Recurse | Select-String -Pattern "IsInRole(" -SimpleMatch