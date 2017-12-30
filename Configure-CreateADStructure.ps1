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

#Create OU Structure
New-AdOrganizationalUnit -Name "digitalMind"

New-AdOrganizationalUnit -Name "Servers" -Path "OU=digitalMind,DC=digitalMind,DC=com"

New-AdOrganizationalUnit -Name "Workstations" -Path "OU=digitalMind,DC=digitalMind,DC=com"

New-AdOrganizationalUnit -Name "Service Accounts" -Path "OU=digitalMind,DC=digitalMind,DC=com"

New-AdOrganizationalUnit -Name "Security Groups" -Path "OU=digitalMind,DC=digitalMind,DC=com"

New-AdOrganizationalUnit -Name "Users" -Path "OU=digitalMind,DC=digitalMind,DC=com"

#Create Service Account

New-ADUser -Name "MDT_BA" -Description "MDT Build Account" -AccountPassword (ConvertTo-SecureString -AsPlainText "P@ssw0rd") -PasswordNeverExpires $true -Path "OU=Service Accounts,OU=digitalMind,DC=digitalMind,DC=com"

New-ADUser -Name "MDT_JD" -Description "MDT Join Domain Account" -AccountPassword (ConvertTo-SecureString -AsPlainText "P@ssw0rd") -PasswordNeverExpires $true -Path "OU=Service Accounts,OU=digitalMind,DC=digitalMind,DC=com"

New-ADUser -Name "CM_NAA" -Description "ConfigMgr Network Access Account" -AccountPassword (ConvertTo-SecureString -AsPlainText "P@ssw0rd") -PasswordNeverExpires $true -Path "OU=Service Accounts,OU=digitalMind,DC=digitalMind,DC=com"

New-ADUser -Name "CM_CP" -Description "ConfigMgr Client Push Account" -AccountPassword (ConvertTo-SecureString -AsPlainText "P@ssw0rd") -PasswordNeverExpires $true -Path "OU=Service Accounts,OU=digitalMind,DC=digitalMind,DC=com"

New-ADUser -Name "CM_SR" -Description "ConfigMgr Reporting Services Account" -AccountPassword (ConvertTo-SecureString -AsPlainText "P@ssw0rd") -PasswordNeverExpires $true -Path "OU=Service Accounts,OU=digitalMind,DC=digitalMind,DC=com"

New-ADUser -Name "CM_JD" -Description "ConfigMgr Join Domain Account" -AccountPassword (ConvertTo-SecureString -AsPlainText "P@ssw0rd") -PasswordNeverExpires $true -Path "OU=Service Accounts,OU=digitalMind,DC=digitalMind,DC=com"


#Create User Accounts
New-ADUser -Name "KiHe" -Description "Standard User" -AccountPassword (ConvertTo-SecureString -AsPlainText "P@ssw0rd") -PasswordNeverExpires $true -Path "OU=Users,OU=digitalMind,DC=digitalMind,DC=com"

New-ADUser -Name "Mike" -Description "Standard User" -AccountPassword (ConvertTo-SecureString -AsPlainText "P@ssw0rd") -PasswordNeverExpires $true -Path "OU=Users,OU=digitalMind,DC=digitalMind,DC=com"

New-ADUser -Name "Frank" -Description "Standard User" -AccountPassword (ConvertTo-SecureString -AsPlainText "P@ssw0rd") -PasswordNeverExpires $true -Path "OU=Users,OU=digitalMind,DC=digitalMind,DC=com"

New-ADUser -Name "Bob" -Description "Standard User" -AccountPassword (ConvertTo-SecureString -AsPlainText "P@ssw0rd") -PasswordNeverExpires $true -Path "OU=Users,OU=digitalMind,DC=digitalMind,DC=com"

