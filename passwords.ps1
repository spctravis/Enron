#using system read file open file ./rockyou.txt saving to variable passwords

$passwords = [System.IO.File]::ReadAllLines("./rockyou.txt")
# randomly get 6443 passwords from the rockyou.txt file and save them to a new file called passwords.txt
$passwords | Get-Random -Count 6443 | Out-File -FilePath "./passwords.txt"
