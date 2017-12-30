#VARS
$PSScriptRoot = split-path -parent $MyInvocation.MyCommand.Definition
$folder_bginfo = "${Env:ProgramFiles}\BGInfo" 
$exec_bginfo = "$folder_bginfo\Bginfo.exe"   
$shortcut_bginfo = "$env:ALLUSERSPROFILE\Microsoft\Windows\Start Menu\Programs\Startup\BGinfo.lnk"
$template_bginfo = "$folder_bginfo\digitalMind.bgi"


#Getting Ready
If(!(Test-Path -Path $folder_bginfo)){New-Item -Path $folder_bginfo -ItemType directory}
If(!(Test-Path -Path $exec_bginfo)){Copy-Item -Path "$PSScriptRoot\source\Bginfo.exe" -Destination $exec_bginfo}
if(!(Test-Path -Path $template_bginfo)){Copy-Item -Path "$PSScriptRoot\source\digitalMind.bgi" -Destination $template_bginfo}
if(!(Test-Path -Path $shortcut_bginfo)){Copy-Item -Path "$PSScriptRoot\source\bginfo.lnk" -Destination $shortcut_bginfo}

#run it
"$exec_bginfo $template_bginfo /TIMER:0 /silent /nolicprompt"

