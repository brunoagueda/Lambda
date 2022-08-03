#Write-Host "Lambda input: $($LambdaInput.data.actionConfiguration.configuration.UserParameters)"

#Import-Module AWS.Tools.Common

Write-Host "Run script"

#Write-Host "Env var: "$env:build_message

Write-Host "User: "$env:runnerUser

Write-Host "Hostname: "$env:runnerUser

Write-Host $LambdaContext.AwsRequestId

Write-Host $LambdaContext.FunctionName

Write-Host "Script finished"

#Write-CPJobSuccessResult -JobId $LambdaContext.AwsRequestId