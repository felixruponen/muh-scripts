# A script to change default mailaddress policy
# Author: Pavel (pavel@multiq.com)

param(
    [string]$inFile
)

if(-not($inFile)) { throw "No input csv file detected!" }
$newUsers = Import-Csv -Delimiter ";" -Path $inFile

foreach ($User in $NewUsers)
 {            
    $Displayname = $User.Firstname + " " + $User.Lastname            
    $Mail = $User.Newmail
    $SeMail = $User.semail
    $DkMail = $User.dkmail
    $NoMail = $User.nomail
    $Login = $User.login
    Write-Output "Turning off Emailaddresspolicy for $Displayname"
    Set-Mailbox -Identity "$Login" -EmailAddressPolicyEnabled $false
    Write-Output "Changing default mailaddresses"
    Set-Mailbox -Identity "$Login" -EmailAddresses SMTP:$Mail,smtp:$SeMail,smtp:$DkMail,smtp:$NoMail          
}
