# A script modify AD user properties according to the CSV list
# Example of the CSV file - updateADProperties-example.csv
# Author: Pavel (pavel.agarkov@multiq.com)

param(
    [string]$inFile
)

if(-not($inFile)) { throw "No input csv file detected!" }

$userList = Import-Csv -Delimiter "," -Path $inFile
# AD search scope for the query
$searchBase = "dc=multiq2,dc=local"
$company = "MultiQ Products"

foreach ($user in $userList)
{
    $mail = $user.mail
    $firstName = $user.givenName
    $lastName = $user.sn
    $displayName = $user.displayName
    $title = $user.title
    $department = $user.department
    $officeName = $user.office
    # keep getting errors on empty fields
    if (!($user.telephoneNumber -eq "")) {$officePhone = $user.telephoneNumber;} else { $officePhone = " ";} 
    if (!($user.mobile -eq "")) {$mobilePhone = $user.mobile;} else { $mobilePhone = " ";} 
    $streetAddress = $user.streetAddress
    $city = $user.l
    $state = $user.st
    $zip = $user.postalCode
    $country = $user.c
    #write-host $firstName $lastName $displayName $title $department $officeName $officePhone $mobilePhone $streetAddress $city $state $zip $country
    write-host "Changing properties for $displayName"
    # using mailaddress as the main filter
    get-aduser -filter "mail -eq '$mail'" -searchbase $searchBase | set-aduser -Title $title -Description $title -Department $department -Office $officeName -OfficePhone $officePhone -MobilePhone $mobilePhone -StreetAddress $streetAddress -City $city -PostalCode $zip -Country $country -Company $company -State $state
    write-host $officePhone
    #if($mobilePhone -eq ""){write-host "EMPY";}
    write-host $mobilePhone
}