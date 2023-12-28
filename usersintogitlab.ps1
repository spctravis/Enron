# using the following formate: curl --request POST --header "PRIVATE-TOKEN: <your_access_token>" "https://gitlab.example.com/api/v4/users?email=user@example.com&password=yourpassword&username=username&name=username"
# make a script that will take the usersandpasswords.csv file and create users in gitlab using the gitlab api

$users = Import-Csv -Path ".\usersandpasswords.csv"

foreach ($user in $users) {
    $username = $user.username
    $password = $user.password
    $name = $user.name
    $email = $user.email
    $url = "https://192.168.52.130/api/v4/users?email=$email&password=$password&username=$username&name=$name"
    #use invoke-webrequest to make a post request to the gitlab api
    #use the -header parameter to add the private token to the request
    #use the -method parameter to specify the request method
    Invoke-WebRequest -Uri $url -Method Post -Headers @{"PRIVATE-TOKEN"="<your_access_token>"}
   
}
