# PowerShell script file to be executed as a AWS Lambda function. 

# Lambda payload
$runnerUser = $LambdaInput.user # usar para pegar o ID
$runnerDevice = $LambdaInput.hostname # usar para pegar o ID

$url = "https://itau-sandbox.cloud.automationanywhere.digital/"
$username = "bruno.creator"
$password = "Agued@#175"

$data = @(
    @{
    username = $username
    password = $password
    }
)

$endpoint1 = $url + "v1/authentication"

$token = (Invoke-RestMethod -Method Post -Uri $endpoint1 -Body ($data | ConvertTo-Json)).token

$endpoint2 = $url + "v1/devices/runasusers/default"

$header = @{
        "X-Authorization" = $token
        "Content-Type" = "application/json"
    }


$body = @(
    @{
        "deviceId" = 140
        "userId" = 420
    }
)

Invoke-RestMethod -Method Post -Uri $endpoint2 -Headers $header -Body ($body | ConvertTo-Json)