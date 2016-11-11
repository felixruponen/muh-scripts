# A script to create external mail contacts from CSV file
# Author: Pavel (pavel@multiq.com)

param(
    [string]$inFile
)

if(-not($inFile)) { throw "No input csv file detected!" }

$newUsers = Import-Csv -Delimiter ";" -Path $inFile

foreach ($User in $NewUsers)
 {            
    $Displayname = $User.Firstname + " " + $User.Lastname            
    $UserFirstname = $User.Firstname            
    $UserLastname = $User.Lastname            
    $OldMail = $User.Oldmail
    $Login = $User.login
    Write-Host "Creating an external mail contact for $Displayname"
    New-MailContact -Name "$Displayname" -DisplayName "$Displayname" -FirstName "$UserFirstname" -LastName "$UserLastname" -Alias "$Login" -ExternalEmailAddress "$OldMail"
    Write-Host "Setting up forwarding to $OldMail"
    Set-Mailbox "$Displayname" -ForwardingAddress "$OldMail"
}
