param (
    [string]$container_name
)

. .\setenv.ps1

function ListContainerFiles {
    Write-Output "Available containers:"
    Write-Output "------------------------"
    $container_files = Get-ChildItem -Path containerfiles
    $container_files | ForEach-Object { Write-Output "- $($_.Name)" }
    Write-Output "------------------------"
    
}

if ( $null -eq $container_name  ) {
    Write-Output "usage: .\run.ps1 {container name}"
    ListContainerFiles
    Exit 1
}

$docker_output = & docker ps | Select-String -Pattern $container_name

$docker_id = $docker_output -split " " | Select-Object -First 1

if ( $null -eq $docker_id ) {
    Write-Output "Error! cannot find container $container_name..." 
    Exit 1
}

$command = "${container_runtime} exec -it $docker_id su - ${container_user}"

Invoke-Expression "$command"