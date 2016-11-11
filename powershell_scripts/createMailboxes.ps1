# A script to create mailboxes for existing users from CSV-file 
# Author: Pavel (pavel@multiq.com)

param(
    [string]$inFile
)

if(-not($inFile)) { throw "No input csv file detected!" }

$newUsers = Import-Csv -Delimiter ";" -Path $inFile

foreach ($User in $newUsers)
 {            
    $Displayname = $User.Firstname + " " + $User.Lastname            
    Write-Host "Creating a mailbox for $Displayname"
    Enable-Mailbox -Identity "$Displayname"
}
