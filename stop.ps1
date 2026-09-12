param (
    [string]$container_name
)

. .\setenv.ps1

if ( $container_name -eq "" ) {
    Write-Output "usage: .\stop.ps1 {container name}"
    Exit 1
}

$docker_output = & docker ps | Select-String -Pattern $container_name

$docker_id = $docker_output -split " " | Select-Object -First 1

if ( $null -eq $docker_id ) {
    Write-Output "Error! cannot find container $container_name..." 
    Exit 1
}

Write-Output "stopping container $container_name with id $docker_id"

$command="docker stop $docker_id"

Invoke-Expression "$command"