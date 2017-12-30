#Setup VM's for digitalMind environnment

### Global VARS ###
$VMLocation = "D:\VMs"
$VMISO = "C:\DigitalMind\ISO\digitalMind.iso"
$VMRouterISO = "C:\DigitalMind\ISO\pfSense-CE-2.4.2-RELEASE-amd64.iso"
$VMNetworkMain = "Antwerp"
$VMNetworkBranch1 = "Amsterdam"
$VMNetworkBranch2 = "London"
$VMNetworkEthernet = "External-LAN"
$VMNetworkWifi = "External-WIFI"


#1 - Create Virtual Switches based on LAN card

#Get Netwerk Adapters (Ethernet Card)
$NetAdapterEthernet = Get-NetAdapter -Name *ether*  #adapt if your card is called differently
$NetAdapterWireless = Get-NetAdapter -Name *Wi-Fi* #adapt if card is called different
#Create External Adapter
New-VMSwitch -Name $VMNetworkEthernet -NetAdapterName $NetAdapterEthernet.Name -AllowManagementOS $true
New-VMSwitch -Name $VMNetworkWifi -NetAdapterName $NetAdapterWireless.Name -AllowManagementOS $true
#Create Internal Adapter - Antwerp
New-VMSwitch -Name $VMNetworkMain -SwitchType Internal
#Create Internal Adapter - Amsterdam
New-VMSwitch -Name $VMNetworkBranch1 -SwitchType Internal
#Create Internal Adapter - London
New-VMSwitch -Name $VMNetworkBranch2 -SwitchType Internal

# Create GW01 - Router VM
$VMName = "dM-GW01"
$VMMemory = 512MB
$VMDiskSize = 60GB
New-VM -Name $VMName -Generation 1 -BootDevice CD -MemoryStartupBytes $VMMemory -Path $VMLocation -NoVHD -Verbose
New-VHD -Path "$VMLocation\$VMName\Virtual Hard Disks\$VMName-Disk1.vhdx" -SizeBytes $VMDiskSize -Verbose
Add-VMHardDiskDrive -VMName $VMName -Path "$VMLocation\$VMName\Virtual Hard Disks\$VMName-Disk1.vhdx" -Verbose
Set-VMDvdDrive -VMName $VMName -Path $VMRouterISO -Verbose
Add-VMNetworkAdapter -VMName $VMName -SwitchName $VMNetworkBranch1
Add-VMNetworkAdapter -VMName $VMName -SwitchName $VMNetworkBranch2
Add-VMNetworkAdapter -VMName $VMName -SwitchName $VMNetworkMain
Add-VMNetworkAdapter -VMName $VMName -SwitchName $VMNetworkEthernet
Add-VMNetworkAdapter -VMName $VMName -SwitchName $VMNetworkWifi
Start-VM -Name $VMName
vmconnect.exe localhost $VMName

# Create DC01
$VMName = "dM-DC01"
$VMMemory = 1024MB
$VMDiskSize = 60GB
New-VM -Name $VMName -Generation 2 -BootDevice CD -MemoryStartupBytes $VMMemory -SwitchName $VMNetworkMain -Path $VMLocation -NoVHD -Verbose
New-VHD -Path "$VMLocation\$VMName\Virtual Hard Disks\$VMName-Disk1.vhdx" -SizeBytes $VMDiskSize -Verbose
Add-VMHardDiskDrive -VMName $VMName -Path "$VMLocation\$VMName\Virtual Hard Disks\$VMName-Disk1.vhdx" -Verbose
Set-VMDvdDrive -VMName $VMName -Path $VMISO -Verbose
Start-VM -Name $VMName
VMConnect localhost $VMName

# Create CM01
$VMName = "dM-CM01"
$VMMemory = 16384MB
$VMDiskSize = 300GB
New-VM -Name $VMName -Generation 2 -BootDevice CD -MemoryStartupBytes $VMMemory -SwitchName $VMNetworkMain -Path $VMLocation -NoVHD -Verbose 
New-VHD -Path "$VMLocation\$VMName\Virtual Hard Disks\$VMName-Disk1.vhdx" -SizeBytes $VMDiskSize -Verbose
Add-VMHardDiskDrive -VMName $VMName -Path "$VMLocation\$VMName\Virtual Hard Disks\$VMName-Disk1.vhdx" -Verbose
Set-VMProcessor -VMName $VMName -Count 2
Set-VMDvdDrive -VMName $VMName -Path $VMISO -Verbose

# Create CM02
$VMName = "dM-CM02"
$VMMemory = 16384MB
$VMDiskSize = 300GB
New-VM -Name $VMName -Generation 2 -BootDevice CD -MemoryStartupBytes $VMMemory -SwitchName $VMNetworkMain -Path $VMLocation -NoVHD -Verbose 
New-VHD -Path "$VMLocation\$VMName\Virtual Hard Disks\$VMName-Disk1.vhdx" -SizeBytes $VMDiskSize -Verbose
Add-VMHardDiskDrive -VMName $VMName -Path "$VMLocation\$VMName\Virtual Hard Disks\$VMName-Disk1.vhdx" -Verbose
Set-VMProcessor -VMName $VMName -Count 2
Set-VMDvdDrive -VMName $VMName -Path $VMISO -Verbose
Start-VM -Name $VMName
VMConnect localhost $VMName

# Create MDT01
$VMName = "dM-MDT01"
$VMMemory = 4096MB
$VMDiskSize = 300GB
New-VM -Name $VMName -Generation 2 -BootDevice CD -MemoryStartupBytes $VMMemory -SwitchName $VMNetworkMain -Path $VMLocation -NoVHD -Verbose
New-VHD -Path "$VMLocation\$VMName\Virtual Hard Disks\$VMName-Disk1.vhdx" -SizeBytes $VMDiskSize -Verbose
Add-VMHardDiskDrive -VMName $VMName -Path "$VMLocation\$VMName\Virtual Hard Disks\$VMName-Disk1.vhdx" -Verbose
Set-VMDvdDrive -VMName $VMName -Path $VMISO -Verbose


# Create WSUS01
$VMName = "dM-WSUS01"
$VMMemory = 4096MB
$VMDiskSize = 300GB
New-VM -Name $VMName -Generation 2 -BootDevice CD -MemoryStartupBytes $VMMemory -SwitchName $VMNetworkMain -Path $VMLocation -NoVHD -Verbose
New-VHD -Path "$VMLocation\$VMName\Virtual Hard Disks\$VMName-Disk1.vhdx" -SizeBytes $VMDiskSize -Verbose
Add-VMHardDiskDrive -VMName $VMName -Path "$VMLocation\$VMName\Virtual Hard Disks\$VMName-Disk1.vhdx" -Verbose
Set-VMDvdDrive -VMName $VMName -Path $VMISO -Verbose

# Create PC01
$VMName = "dM-PC01"
$VMMemory = 2048MB
$VMDiskSize = 60GB
New-VM -Name $VMName -Generation 2 -BootDevice CD -MemoryStartupBytes $VMMemory -SwitchName $VMNetworkMain -Path $VMLocation -NoVHD -Verbose
New-VHD -Path "$VMLocation\$VMName\Virtual Hard Disks\$VMName-Disk1.vhdx" -SizeBytes $VMDiskSize -Verbose
Add-VMHardDiskDrive -VMName $VMName -Path "$VMLocation\$VMName\Virtual Hard Disks\$VMName-Disk1.vhdx" -Verbose
Set-VMDvdDrive -VMName $VMName -Path $VMISO -Verbose
Start-VM -Name $VMName
VMConnect localhost $VMName

# Create PC02
$VMName = "dM-PC02"
$VMMemory = 2048MB
$VMDiskSize = 60GB
New-VM -Name $VMName -Generation 2 -BootDevice CD -MemoryStartupBytes $VMMemory -SwitchName $VMNetworkMain -Path $VMLocation -NoVHD -Verbose
New-VHD -Path "$VMLocation\$VMName\Virtual Hard Disks\$VMName-Disk1.vhdx" -SizeBytes $VMDiskSize -Verbose
Add-VMHardDiskDrive -VMName $VMName -Path "$VMLocation\$VMName\Virtual Hard Disks\$VMName-Disk1.vhdx" -Verbose
Set-VMDvdDrive -VMName $VMName -Path $VMISO -Verbose
Start-VM -Name $VMName
VMConnect localhost $VMName


# Create PC03
$VMName = "dM-PC03"
$VMMemory = 2048MB
$VMDiskSize = 60GB
New-VM -Name $VMName -Generation 2 -BootDevice CD -MemoryStartupBytes $VMMemory -SwitchName $VMNetworkMain -Path $VMLocation -NoVHD -Verbose
New-VHD -Path "$VMLocation\$VMName\Virtual Hard Disks\$VMName-Disk1.vhdx" -SizeBytes $VMDiskSize -Verbose
Add-VMHardDiskDrive -VMName $VMName -Path "$VMLocation\$VMName\Virtual Hard Disks\$VMName-Disk1.vhdx" -Verbose
Set-VMDvdDrive -VMName $VMName -Path $VMISO -Verbose
Start-VM -Name $VMName
VMConnect localhost $VMName



# Create PC04
$VMName = "dM-PC04"
$VMMemory = 2048MB
$VMDiskSize = 60GB
New-VM -Name $VMName -Generation 2 -BootDevice CD -MemoryStartupBytes $VMMemory -SwitchName $VMNetworkBranch1 -Path $VMLocation -NoVHD -Verbose
New-VHD -Path "$VMLocation\$VMName\Virtual Hard Disks\$VMName-Disk1.vhdx" -SizeBytes $VMDiskSize -Verbose
Add-VMHardDiskDrive -VMName $VMName -Path "$VMLocation\$VMName\Virtual Hard Disks\$VMName-Disk1.vhdx" -Verbose
Set-VMDvdDrive -VMName $VMName -Path $VMISO -Verbose
Start-VM -Name $VMName
VMConnect localhost $VMName


# Create PC05
$VMName = "dM-PC05"
$VMMemory = 2048MB
$VMDiskSize = 60GB
New-VM -Name $VMName -Generation 2 -BootDevice CD -MemoryStartupBytes $VMMemory -SwitchName $VMNetworkBranch1 -Path $VMLocation -NoVHD -Verbose
New-VHD -Path "$VMLocation\$VMName\Virtual Hard Disks\$VMName-Disk1.vhdx" -SizeBytes $VMDiskSize -Verbose
Add-VMHardDiskDrive -VMName $VMName -Path "$VMLocation\$VMName\Virtual Hard Disks\$VMName-Disk1.vhdx" -Verbose
Set-VMDvdDrive -VMName $VMName -Path $VMISO -Verbose
Start-VM -Name $VMName
VMConnect localhost $VMName

# Create PC06
$VMName = "dM-PC06"
$VMMemory = 2048MB
$VMDiskSize = 60GB
New-VM -Name $VMName -Generation 2 -BootDevice CD -MemoryStartupBytes $VMMemory -SwitchName $VMNetworkBranch1 -Path $VMLocation -NoVHD -Verbose
New-VHD -Path "$VMLocation\$VMName\Virtual Hard Disks\$VMName-Disk1.vhdx" -SizeBytes $VMDiskSize -Verbose
Add-VMHardDiskDrive -VMName $VMName -Path "$VMLocation\$VMName\Virtual Hard Disks\$VMName-Disk1.vhdx" -Verbose
Set-VMDvdDrive -VMName $VMName -Path $VMISO -Verbose
Start-VM -Name $VMName
VMConnect localhost $VMName