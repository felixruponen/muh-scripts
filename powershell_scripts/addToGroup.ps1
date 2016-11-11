# A script to add users to a group, specified as argument 2
# Author: Pavel (pavel@multiq.com)

param(
    [string]$inFile,
    [string]$groupName
)

if(-not($inFile) -or -not($groupName)) { throw "    usage addToGroup.ps1 <csvlist> <groupname>" }

$newUsers = Import-Csv -Delimiter ";" -Path $inFile

foreach ($User in $NewUsers)
 {            
    $Login = $User.login
    Write-Output "Adding $Displayname to $groupName"
    Add-ADGroupMember "$groupName" "$Login"
}
