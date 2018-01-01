# install chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# install oh-my-posh
choco install ConEmu
Install-Module posh-git -Scope CurrentUser
Install-Module oh-my-posh -Scope CurrentUser
