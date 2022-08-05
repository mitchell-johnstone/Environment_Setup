<#PSScriptInfo
 
.VERSION 1.0
 
.GUID 4d6860ae-67e0-46ed-9a8d-0e9a3e4f4631
 
.AUTHOR duluca
 
.COMPANYNAME
 
.COPYRIGHT
 
.TAGS
 
.LICENSEURI
 
.PROJECTURI
 
.ICONURI
 
.EXTERNALMODULEDEPENDENCIES
 
.REQUIREDSCRIPTS
 
.EXTERNALSCRIPTDEPENDENCIES
 
.RELEASENOTES
 
 
#>

<#
 
.DESCRIPTION
 Setup a web development environment with Git, Node, VS Code and AWS
#>
Param()

# This script is intentionally kept simple to demonstrate basic automation techniques.

Write-Output "You must run this script in an elevated command shell, using 'Run as Administator'"

$title = "Setup Web Development Environment"
$message = "Select the appropriate option to continue (Absolutely NO WARRANTIES or GUARANTEES are provided):"

$yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Install Software using Chocolatey", `
  "Setup development environment."

$no = New-Object System.Management.Automation.Host.ChoiceDescription "&Exit", `
  "Do not execute script."

$options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)

$result = $host.ui.PromptForChoice($title, $message, $options, 1)

switch ($result) {
  0 {
    Write-Output "Installing chocolatey"
    Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    Write-Output "Refreshing environment variables. If rest of the scritp fails, restart elevated shell and rerun script."
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

    Write-Output "Assuming chocolatey is already installed"
    Write-Output "Installing Git & GitHub Desktop"
    choco.exe upgrade git github-desktop -y

    Write-Output "Installing NodeJS"
    choco.exe upgrade nodejs-lts -y

    Write-Output "Installing Docker"
    choco.exe upgrade docker docker-for-windows -y

    Write-Output "Installing AWS"
    choco.exe upgrade awscli -y

    Write-Output "Installing VS Code"
    choco.exe upgrade VisualStudioCode -y

    Write-Output "Installing Notepad++"
    choco.exe upgrade notepadplusplus -y

    Write-Output "Installing haskell-stack"
    choco.exe upgrade haskell-stack -y

    Write-Output "Installing ruby"
    choco.exe upgrade ruby -y

    Write-Output "Installing rust"
    choco.exe upgrade rust -y

    Write-Output "Installing python3"
    choco.exe upgrade python3 -y

    Write-Output "Installing googlechrome"
    choco.exe upgrade googlechrome -y

    Write-Output "Installing firefox"
    choco.exe upgrade firefox -y

    Write-Output "Installing adobereader"
    choco.exe upgrade adobereader -y

    Write-Output "Installing sql-server-management-studio"
    choco.exe upgrade sql-server-management-studio -y

    Write-Output "Installing 7zip"
    choco.exe upgrade 7zip -y

    Write-Output "Installing filezilla"
    choco.exe upgrade filezilla -y

    Write-Output "Installing skype"
    choco.exe upgrade skype -y

    Write-Output "Installing spotify"
    choco.exe upgrade spotify --ignore-checksums -y

    RefreshEnv.cmd
    Write-Output "Results:"
    Write-Output "Verify installation of AWS, Docker, GitHub Desktop and VS Code manually."
    $gitVersion = git.exe --version
    Write-Output "git: $gitVersion"
    $nodeVersion = node.exe -v
    Write-Output "Node: $nodeVersion"
    $npmVersion = npm.cmd -v
    Write-Output "npm: $npmVersion"
  }
  1 { "Aborted." }
}
