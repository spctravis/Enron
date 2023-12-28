$users = Import-Csv -Path ".\users.csv"
$passwords = Get-Content -Path ".\passwords.txt"

# for each user in the users.csv file choose a random password from the rockyou.txt file and save it to a new file called usersandpasswordds.csv
foreach ($user in $users) {
    $password = $passwords | Get-Random
    $user | Add-Member -MemberType NoteProperty -Name "Password" -Value $password
    $user | Export-Csv -Path ".\usersandpasswords.csv" -Append -NoTypeInformation
}
