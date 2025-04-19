param (
    [string]$container_name,
    [string]$tag = "latest",
    [string]$container_owner = "mmontuori"
)

$container_file = "containerfiles/$container_name"

function ListContainerFiles {
    Write-Output "Available containers:"
    Write-Output "------------------------"
    $container_files = Get-ChildItem -Path containerfiles
    $container_files | ForEach-Object { Write-Output "- $($_.Name)" }
    Write-Output "------------------------"
    
}

if ( $container_name -eq "" ) {
    Write-Output "usage: .\build.ps1 {container name} [container tag]"
    Write-Output ""
    ListContainerFiles
    Exit 1
}

$path = Test-Path "$container_file"

if ( $path -eq $false ) {
    Write-Error "Error! cannot find container file $container_file..." 
    Exit 1
}

Write-Output "building ${container_owner}/${container_name} with tag:${tag}"

$command = "docker build --file $container_file -t ${container_owner}/${container_name}:${tag} ."

Invoke-Expression "$command"