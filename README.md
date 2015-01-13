# Windows workflow via Windows PowerShell

First you might not be familiar that Windows has something called PowerShell, not just a boring old Command Line. Its physical location is ```C:\Windows\System32\WindowsPowerShell\``` :point_left:

To view quickly (for purposes of adding to taskbar/start menu) Click ```Windows Key``` + ```R```, then type ```PowerShell```, then ```Enter``` or click on PowerShell.

### Setting up PowerShell to allow use of command line script extensions

Set-ExecutionPolicy will stop you from using basic command line scripts, either by means of something called "Group Policy" (which if not set by a system admin, can be set by you in most cases.  Reference Link for ExecutionPolicy: [Set PowerShell Execution Policies | 4SysOp](https://4sysops.com/archives/set-powershell-execution-policy-with-group-policy/)

*    To see your system Execution Policies type ```Get-ExecutionPolicy``` in the PowerShell command line.

*    Click ```Windows Key``` + ```R```, then type ```Group Policy```, then Enter or click on Edit Group Policy.

*    On Windows 7/8, Click ```Computer Configuration``` > ```Administrative Templates``` > ```Windows Components``` > ```Windows PowerShell```

*    Click on ```Turn on Script Execution``` > ```Click Enabled``` > Choose ```Allow local scripts and remotely signed scripts``` from the dropdown menu > Click ```Apply```, then ```OK```. Then close or ```X``` out of the Global Policy Editor.

*    The bonus of doing this is two-fold. Now only signed/local scripts work (anti-malware) and you get access to some pretty cool time saving PowerShell modules.


### Installing modules, install managers, and themes to PowerShell.

* Click Windows Key + R, then type PowerShell, then Enter or click on PowerShell.


* Install **PsGet**, [Powershell Modules Installer](http://psget.net) 
  - Follow install instructions from the PsGet website. :hurtrealbad: Installing PsGet was a manual pain my first run through, so I included in the example folder under modules. If you want to do it manually, enter ```(new-object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1") | iex``` from the command line.


* Install **Posh-Git**, [PowerShell Git Command Environment](https://github.com/dahlbyk/posh-git) 
  - Type ```install-module posh-git``` from the PowerShell Command Line.
  - Load posh-git example profile, posting this in your PowerShell Environment
```. C:\Users\ **Your Login** \Documents\WindowsPowerShell\Modules\posh-git\profile.example.ps1```

* Install **Scoop**, [PowerShell Install Manager](http://scoop.sh)
  - Type ```iex (new-object net.webclient).downloadstring('https://get.scoop.sh')``` from the command line.

  - With Scoop you can install modules such as   ```Curl```, ```7Zip```, ```Sudo```, ```Vim``` and ```Concfg```, and optionally ```Git-Flow```, etc.
  
  - Example: Copy/Paste ```iex (new-object net.webclient).downloadstring('https://get.scoop.sh') | scoop install concfg | scoop install curl | scoop bucket add extras | scoop install git-flow``` into your command line.
  
  - Scoops Git Repositories: [Luke Sampson/Scoop](https://github.com/lukesampson/scoop) and [Luke Sampson/Scoop-Extras](https://github.com/lukesampson/scoopextras). In the main Scoop Repository is a folder called [Bucket](https://github.com/lukesampson/scoop/tree/master/bucket/).

* Extending **Scoop** for theme installations:
  - (Optional/Recommended) Install [Solarized Theme](http://ethanschoonover.com/solarized) from Concfg via command line ```Concfg import solarized small```.

* Fixing the **Scoop** Install of **Git-Flow**:
  - If you plan on using Git-Flow, it requires a few files to be added to Your Git Directories ```/bin``` folder. I included those files which you can grab here: [Git Flow Dependencies](https://github.com/tmagnusson/powershell-example-profile/tree/master/Scoop%20-%20git-flow%20installation%20fix)
  
### Symbolic links done effectively via MKLINK PowerShell Module
 * Make Correct Symlinks using the [MKLINK PowerShell Module](https://github.com/jpoehls/Poshato/blob/master/mklink.psm1) from Joshua Poehls [Poshato](https://github.com/jpoehls/Poshato), I only took the mklink.psm1 file from the repository, but feel free to use the whole addon if you wish.
 Creating Hard Symlink in Windows with MKLINKS Module (Included in Example Folder Modules) Reference Src: [http://zduck.com/2013/mklink-powershell-module/]
    - The first directory doesn't technically exist (to be symlinked) within the folder, the second exists.

 **Usage Example:**
 ```New-Symlink "c:\foo\bar" "c:\foo\baz" OR
 Remove-Symlink "c:\foo\bar"```
 ```New-Junction "c:\foo\bar" "c:\foo\baz" OR
 Remove-Junction "c:\foo\bar"```
