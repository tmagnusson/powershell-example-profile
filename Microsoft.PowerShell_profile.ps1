# Using Windows PowerShell over other editors such as Cygwin Mintty or the default Windows CMD Line.
# --------------------------------------------------------------------------------------------------

# Preparing Windows PowerShell:

#### First you might not be familiar that Windows has something called PowerShell, not just a boring old Command Line. Its physical location is in most cases is "C:\Windows\System32\WindowsPowerShell\"
#    - To view quickly (for purposes of adding to taskbar/start menu)
#      - Click Windows Key + R, then type PowerShell, then Enter or click on PowerShell.

# Setting Windows PowerShell to allow Script Extensions:

#### Set-ExecutionPolicy will stop you from using basic command line scripts, either by means of something called "Group Policy" (which if not set by a system admin, can be set by you in most cases. 3M tends to have half of them already set to 'RemoteSigned.') Reference Link for ExecutionPolicy: https://4sysops.com/archives/set-powershell-execution-policy-with-group-policy/
#    - To see your system Execution Policies type Get-ExecutionPolicy
#    - Click Windows Key + R, then type Group Policy, then Enter or click on Edit Group Policy.
#    - On Windows 7/8, Click Computer Configuration => Administrative Templates => Windows Components => Windows PowerShell
#    - Click on 'Turn on Script Execution' => Click Enabled => Choose 'Allow local scripts and remotely signed scripts' from the dropdown menu => Click Apply, then OK. 
#    - Close Global Policy Editor.
#    - The bonus of doing this is two-fold. Now only signed/local scripts work (anti-malware) and you get to use some pretty cool time saving tools via PowerShell
#    - Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Confirm

# 1a. Extract and Save my example Powershell Profile Folder in C:\Users\[Your Personal and/or 3M Account Here]\Documents\WindowsPowerShell\, Make sure Microsoft.PowerShell_profile.ps1 is in the root directory of the folder.

# 1b. Click Windows Key + R, then type PowerShell, then Enter or click on PowerShell.

# 2a. Install PsGet [http://psget.net] (Installs PowerShell Modules. Already Included in Example Module Folder.) Follow install instructions from the PsGet website. Installing PsGet was a manual pain my first run through, so I included in the example folder under modules. If you want to do it manually, enter '(new-object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1") | iex' from the command line.

# 2b. Install Posh-Git [https://github.com/dahlbyk/posh-git] (PowerShell Git Command Environment)
#    - Type 'install-module posh-git' from the PowerShell Command Line (No quotations).
# 2c. Load posh-git example profile - CHANGE ADDRESS ON DIFFERENT MACHINE
. 'C:\Users\a5cldzz\Documents\WindowsPowerShell\Modules\posh-git\profile.example.ps1'

# 3a. Install Scoop. [http://scoop.sh] (Scoop is an Install Manager for PowerShell)
#  - Have Scoop install Curl, 7Zip, Sudo, Vim and Concfg, and optionally Git-Flow
# 	 - In the command line run the batch installer for the above (no outer quotations) 'iex (new-object net.webclient).downloadstring('https://get.scoop.sh') | scoop install concfg | scoop install curl | scoop bucket add extras | scoop install git-flow'
#    Scoops Git Repositories: [https://github.com/lukesampson/scoop] and [https://github.com/lukesampson/scoop-extras]. In the main Scoop Repository is a folder called bucket, within is options to what you can install via the command line "Scoop install [item]"

# 3b. (Optional) Install Solarized Theme from Concfg via command line 'Concfg import solarized small'
#    -  Script Src: [http://ethanschoonover.com/solarized]

# 4. Make Correct Symlinks using MKLINK extension from Joshua Poehls Poshato [https://github.com/jpoehls/Poshato], I only took the mklink.psm1 file from the repository, but feel free to use the whole addon for PowerShell.
# Creating Hard Symlink in Windows with MKLINKS Module (Included in Example Folder Modules) Reference Src: [http://zduck.com/2013/mklink-powershell-module/]
#    - The first directory doesn't technically exist (to be symlinked) within the folder, the second exists.

#  Usage Example:
# New-Symlink "c:\foo\bar" "c:\foo\baz"
# Remove-Symlink "c:\foo\bar"

# --------------------------------------------------------------------------------------------------
# FOR GLOBAL BASE: The fix for the JS\BUILD folder for the develop branch
--------------------------------------------------------------------------------------------------
#    - New-Symlink C:\[Your Development Path...]\beepdev-us\global-base\skin\frontend\rwd\global-base\fuze\js\build C:\[Your Development Path...]\beepdev-us\global-base\skin\frontend\rwd\global-base\fuze\js\

# --------------------------------------------------------------------------------------------------
# FOR PHP 5.6 WITH ZEND: Magento on PHP 5.6 Fires Deprecation Errors in Development. [https://code007.wordpress.com/2014/10/14/how-to-fix-php-5-6-deprecated-messages-in-magento/comment-page-1/]
# --------------------------------------------------------------------------------------------------
# Zend Fix for PHP 5.6 and Magento Enterprise
#    - New-Junction C:\[Your Development Path...]\beepdev-us\global-base\app\code\local\Zend C:\[Your Development Path...]\beepdev-us\Zend

# --------------------------------------------------------------------------------------------------
# FOR A SEPERATE MEDIA FOLDER: If you want to separate the media folder from the GLOBAL-BASE if you have to reset from a git pull error.
# --------------------------------------------------------------------------------------------------
#    - New-Junction C:\[Your Development Path...]\beepdev-us\global-base\media C:\[Your Development Path...]\beepdev-us\media

Set-ExecutionPolicy Bypass -Scope CurrentUser

# Comment the import-module convert-image2text.ps1 out if you don't want an ASCII image faceplace
# Script Src: [http://ps1.soapyfrog.com/2007/01/07/convert-images-to-text-ascii-art/]
import-module convert-image2text.ps1

# Imports Poshato MKLINK Extension, Comment it out if you prefer using GUI applications like Junction Link-Magic [http://rekenwonder.com/linkMagic.htm] over the command line feature.
Import-Module mklink.psm1

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

# $global:CurrentUser = import[System.Security.Principal.WindowsIdentity]::GetCurrent()
# function prompt {
#    $host.ui.rawui.WindowTitle = $CurrentUser.Name + " " + $Host.Name + " " + $Host.Version + " Line: " + $host.UI.RawUI.CursorPosition.Y
#    Write-Host ("PS " + $(get-location) +">") -nonewline -foregroundcolor Cyan -backgroundcolor DarkGrey
#    return " "
# }

# Change the addresses below to have your powershell automatically open to your development environment
# Set File Locale - CHANGE ADDRESS ON DIFFERENT MACHINE
Set-Location c:\_development\_xampp\htdocs\beep\
Set-Variable -name home -value c:\_development\_xampp\htdocs\beep\ -force

# Unlocks Copy from PowerShell
new-alias  Out-Clipboard $env:SystemRoot\system32\clip.exe
$crt = PowerShell -NoProfile -STA -Command {
	Add-Type -Assembly PresentationCore
	[Windows.Clipboard]::GetText()
}

# Allows Paste Content Directly to PowerShell
function Get-ClipboardText()
{
    Add-Type -AssemblyName System.Windows.Forms
    $tb = New-Object System.Windows.Forms.TextBox
    $tb.Multiline = $true
    $tb.Paste()
    $tb.Text
}
