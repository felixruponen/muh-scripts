# A script to create users from CSV-file and generate a textfile with passwords
# Author: Pavel (pavel@multiq.com)

param(
    [string]$inFile,
    [string]$outFile
)

if(-not($inFile) -or -not($groupName)) { throw "    usage createUsers.ps1 <csv list> <new text file>" }

$newUsers = Import-Csv -Delimiter ";" -Path $inFile
# Random pwd generation
[Reflection.Assembly]::LoadWithPartialName("System.Web") > $null
$num = 1
# Full path to OU where the users will be created, company and country name
$OU = ""
$company = ""
$country = ""
# Domain the users will be created in
$domain = ""

foreach ($User in $newUsers)
 {            
    $Displayname = $User.Firstname + " " + $User.Lastname            
    $UserFirstname = $User.Firstname            
    $UserLastname = $User.Lastname            
    $UPN = $User.login + "@" + $domain
    $Mail = $User.Newmail
    $Login = $User.login
    $Password = [System.Web.Security.Membership]::GeneratePassword(8,2)
    Add-Content -Value "User $num `t $Displayname `t $Mail `t $Login `t $Password" -Path $outFile
    $num++             
    New-ADUser -Company $company -Country $country -EmailAddress $Mail -Name "$Displayname" -DisplayName "$Displayname" -UserPrincipalName $UPN -SamAccountName $Login -GivenName "$UserFirstname" -Surname "$UserLastname" -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) -Enabled $true -Path $OU -ChangePasswordAtLogon $false -PasswordNeverExpires $true -server $domain
}
