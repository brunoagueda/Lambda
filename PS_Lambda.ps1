# Required modules
Import-Module AWSPowerShell -Force
Import-Module AWSLambdaPSCore -Force

$accesKey = 'AKIA4GYYM57TW4KQK5HW'
$secretKey = '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'

Initialize-AWSDefaultConfiguration -AccessKey $accesKey -SecretKey $secretKey -Region us-east-1

# Get current Lambda functions
Get-LMFunctionList

#Get-AWSPowerShellLambdaTemplate

#New-AWSPowerShellLambda -ScriptName PSTest -Template Basic

# Publish the new PowerShell based Lambda function
$publishPSLambdaParams = @{
    Name = 'PSTest'
    ScriptPath = '.\PSTest\PSTest.ps1'
    Region = 'us-east-1'
    IAMRoleArn = 'LambdaRoleForCodePipeline'
}

Publish-AWSPowerShellLambda @publishPSLambdaParams

$payload =@{Message = 'Mensagem de teste 2'} | ConvertTo-Json

$results = Invoke-LMFunction -FunctionName PSTest -Payload $payload #-InvocationType Event
$results | Select-Object -Property *

$logs = Get-CWLFilteredLogEvent -LogGroupName /aws/lambda/PSTest
$logs.Events

Get-Command -Name *aws*

Update-LMFunctionConfiguration -FunctionName PSTest -Environment_Variable @{"mensagem"="teste troca"}