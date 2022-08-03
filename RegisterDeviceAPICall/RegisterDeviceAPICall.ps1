# PowerShell script file to be executed as a AWS Lambda function. 


#region API Variables #######################################################################################

# running variables
#$runnerUser = $env:runnerUser
#$runnerDevice = $env:runnerDevice

# test variables
$runnerUser = "bruno.runner"
$runnerDevice = "EC2AMAZ-23QLTMK"

$url = "https://itau-sandbox.cloud.automationanywhere.digital/"
$userAA = "bruno.creator"
$password = "Agued@#175"
#endregion #######################################################################################



#region Authentication API #######################################################################################
$data = @{
    "username" = $userAA
    "password" = $password
    } | ConvertTo-Json

$authEndpoint = $url + "v1/authentication"

$token = (Invoke-RestMethod -Method Post -Uri $authEndpoint -Body $data).token
#endregion #######################################################################################



#region Get runner user ID #######################################################################################
$userEndpoint = $url + "v1/usermanagement/users/list"

$header = @{
    "X-Authorization" = $token
    "Content-Type"    = "application/json"
}


$body = @{
    
    "filter" = @{
        "operator" = "substring"
        "field"   = "username"
        "value" = $runnerUser
    }
} | ConvertTo-Json

$userId = (Invoke-RestMethod -Method Post -Uri $userEndpoint -Headers $header -Body $body).list.id

#endregion #######################################################################################



#region Get runner device ID #######################################################################################
$deviceEndpoint = $url + "v2/devices/list"

$header = @{
    "X-Authorization" = $token
    "Content-Type"    = "application/json"
}


$body = @{
    "filter" = @{
        "operator" = "substring"
        "field"   = "hostName"
        "value" = $runnerDevice
    }
} | ConvertTo-Json

$deviceId = (Invoke-RestMethod -Method Post -Uri $deviceEndpoint -Headers $header -Body $body).list.id

#endregion #######################################################################################



#region Bind user to device #######################################################################################
$registerEndpoint = $url + "v1/devices/runasusers/default"

$header = @{
        "X-Authorization" = $token
        "Content-Type" = "application/json"
    }


$body = @(
    @{
        "deviceId" = $deviceId
        "userId" = $userId
    }
)

Invoke-RestMethod -Method Post -Uri $registerEndpoint -Headers $header -Body ($body | ConvertTo-Json)
#endregion #######################################################################################
