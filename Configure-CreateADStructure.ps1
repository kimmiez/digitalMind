<#
.Synopsis
    Sample script for Hydration Kit
.DESCRIPTION
    Created: 2017-12-23
    Version: 1.0

    Author : Kim Heyrman
    Twitter: @kimmiez_h
    Blog   : http://kheyrman.be

    Purpose: Create AD Structure

    Disclaimer: This script is provided "AS IS"

.EXAMPLE
    NA
#>

# Determine where to do the logging 
$tsenv = New-Object -COMObject Microsoft.SMS.TSEnvironment 
$logPath = $tsenv.Value("LogPath") 
$logFile = "$logPath\$($myInvocation.MyCommand).log" 

# Start the logging 
Start-Transcript $logFile 
Write-Host "Logging to $logFile" 


#Create OU Structure
New-AdOrganizationalUnit -Name "dM"

New-AdOrganizationalUnit -Name "Servers" -Path "OU=dM,DC=digitalMind,DC=com"

New-AdOrganizationalUnit -Name "Workstations" -Path "OU=dM,DC=digitalMind,DC=com"

New-AdOrganizationalUnit -Name "Service Accounts" -Path "OU=dM,DC=digitalMind,DC=com"

New-AdOrganizationalUnit -Name "Security Groups" -Path "OU=dM,DC=digitalMind,DC=com"

New-AdOrganizationalUnit -Name "Users" -Path "OU=dM,DC=digitalMind,DC=com"

#Create Service Account

New-ADUser -Name "MDT_BA" -Description "MDT Build Account" -AccountPassword (ConvertTo-SecureString -String "P@ssw0rd" -AsPlainText -Force) -PasswordNeverExpires $true -Path "OU=Service Accounts,OU=dM,DC=digitalMind,DC=com" -Enabled $true

New-ADUser -Name "MDT_JD" -Description "MDT Join Domain Account" -AccountPassword (ConvertTo-SecureString -String "P@ssw0rd" -AsPlainText -Force) -PasswordNeverExpires $true -Path "OU=Service Accounts,OU=dM,DC=digitalMind,DC=com" -Enabled $true

New-ADUser -Name "CM_NAA" -Description "ConfigMgr Network Access Account" -AccountPassword (ConvertTo-SecureString -String "P@ssw0rd" -AsPlainText -Force) -PasswordNeverExpires $true -Path "OU=Service Accounts,OU=dM,DC=digitalMind,DC=com" -Enabled $true

New-ADUser -Name "CM_CP" -Description "ConfigMgr Client Push Account" -AccountPassword (ConvertTo-SecureString -String "P@ssw0rd" -AsPlainText -Force) -PasswordNeverExpires $true -Path "OU=Service Accounts,OU=dM,DC=digitalMind,DC=com" -Enabled $true

New-ADUser -Name "CM_SR" -Description "ConfigMgr Reporting Services Account" -AccountPassword (ConvertTo-SecureString -String "P@ssw0rd" -AsPlainText -Force) -PasswordNeverExpires $true -Path "OU=Service Accounts,OU=dM,DC=digitalMind,DC=com" -Enabled $true

New-ADUser -Name "CM_JD" -Description "ConfigMgr Join Domain Account" -AccountPassword (ConvertTo-SecureString -String "P@ssw0rd" -AsPlainText -Force) -PasswordNeverExpires $true -Path "OU=Service Accounts,OU=dM,DC=digitalMind,DC=com" -Enabled $true


#Create User Accounts
New-ADUser -Name "KiHe" -Description "Standard User" -AccountPassword (ConvertTo-SecureString -String "P@ssw0rd" -AsPlainText -Force) -PasswordNeverExpires $true -Path "OU=Users,OU=dM,DC=digitalMind,DC=com" -Enabled $true

New-ADUser -Name "Mike" -Description "Standard User" -AccountPassword (ConvertTo-SecureString -String "P@ssw0rd" -AsPlainText -Force) -PasswordNeverExpires $true -Path "OU=Users,OU=dM,DC=digitalMind,DC=com" -Enabled $true

New-ADUser -Name "Frank" -Description "Standard User" -AccountPassword (ConvertTo-SecureString -String "P@ssw0rd" -AsPlainText -Force) -PasswordNeverExpires $true -Path "OU=Users,OU=dM,DC=digitalMind,DC=com" -Enabled $true

New-ADUser -Name "Bob" -Description "Standard User" -AccountPassword (ConvertTo-SecureString -String "P@ssw0rd" -AsPlainText -Force) -PasswordNeverExpires $true -Path "OU=Users,OU=dM,DC=digitalMind,DC=com" -Enabled $true


# Stop logging 
Stop-Transcript