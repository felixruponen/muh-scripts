# A script modify AD user properties according to the CSV list
# Author: Pavel (pavel@multiq.com)

param(
    [string]$inFile
)

if(-not($inFile)) { throw "No input csv file detected!" }

$userList = Import-Csv -Delimiter "," -Path $inFile
# AD search scope for the query
$searchBase = ""
$company = ""

foreach ($user in $userList)
{
    $mail = $user.mail
    $displayName = $user.displayName
    $title = $user.title
    $department = $user.department
    $officeName = $user.office
    $officePhone = $user.telephoneNumber
    $mobilePhone = $user.mobile
    $streetAddress = $user.streetAddress
    $city = $user.l
    $state = $user.st
    $zip = $user.postalCode
    $country = $user.c
    write-host "Changing properties for $displayName"
    # filtering out users with mailboxes only
    get-aduser -filter "mail -eq '$mail'" -searchbase $searchBase | set-aduser -Title $title -Description $title -Department $department -Office $officeName -OfficePhone $officePhone -MobilePhone $mobilePhone -StreetAddress $streetAddress -City $city -PostalCode $zip -Country $country -Company $company -State $state
}
