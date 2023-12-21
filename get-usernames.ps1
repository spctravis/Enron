#$data = import-csv ./emails.csv
$uniqueEmails = @{}
$data.message | ForEach-Object {
    $lines = $_ -split "`n"
    if($lines[2] -match "^From: (.*)"){$email = $lines[2] | Select-String -Pattern "^From: (.*)"  | ForEach-Object { $_.Matches } | ForEach-Object { $_.Groups[1].Value }
        if ($email -match "\@enron.com$") {    
            $names = ($email -split '@')[0]
                if (-not $uniqueEmails.ContainsKey($email)) {
                    if($names -match "\.\."){ $names = $names -replace "\.\.", "."}    
                    $names = $names -split '\.'
                    
                    #$names = if(($names -split '.', 2)[1] -ne $null) { $names = $names[1] }
                    $firstName = $names[0].Substring(0,1).ToUpper() + $names[0].Substring(1).ToLower()
                    $lastName = $names[1].Substring(0,1).ToUpper() + $names[1].Substring(1).ToLower()
                    
                    $uniqueEmails[$email] = @{
                        'FirstName' = $firstName
                        'LastName' = $lastName

                    }
                }
            }
        }
    }

$uniqueEmails
$csvData = $uniqueEmails.Keys | ForEach-Object {
    $email = $_
    $user = $uniqueEmails[$email]
    New-Object -TypeName PSObject -Property @{
        'FirstName' = $user.FirstName
        'LastName' = $user.LastName
        'UserPrincipalName' = $email
        'DisplayName' = "$($user.FirstName) $($user.LastName)"
    }
}
$csvData | Export-Csv -Path './users.csv' -NoTypeInformation