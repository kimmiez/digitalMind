$ISO = "C:\Sources\en_windows_server_2016_x64_dvd_9718492.iso"
$MountFolder = "C:\Mount" 
$RefImage = "C:\Setup\REFWS2016-001.wim" 

# Verify that the ISO and CU files existnote 
if (!(Test-Path -path $ISO)) {Write-Warning "Could not find Windows Server 2016 ISO file. Aborting...";Break} 

# Mount the Windows Server 2016 ISO 
Mount-DiskImage -ImagePath $ISO 
$ISOImage = Get-DiskImage -ImagePath $ISO | Get-Volume 
$ISODrive = [string]$ISOImage.DriveLetter+":" 
   
# Extract the Windows Server 2016 Standard index to a new WIM 
Export-WindowsImage -SourceImagePath "$ISODrive\Sources\install.wim" -SourceName "Windows Server 2016 SERVERSTANDARD" -DestinationImagePath $RefImage 
   
# Add the KB3201845 CU to the Windows Server 2016 Standardimage 
if (!(Test-Path -path $MountFolder)) {New-Item -path $MountFolder -ItemType Directory} 
Mount-WindowsImage -ImagePath $RefImage -Index 1 -Path $MountFolder 

# Add .NET Framework 3.5.1 to the Windows Server 2016 Standard image 
Add-WindowsPackage -PackagePath $ISODrive\sources\sxs\microsoft-windows-netfx3-ondemand-package.cab -Path $MountFolder 
  
# Dismount the Windows Server 2016 Standard image 
DisMount-WindowsImage -Path $MountFolder -Save 
   
# Dismount the Windows Server 2016 ISO 
Dismount-DiskImage -ImagePath $ISO 

