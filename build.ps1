$container_name = $args[0]
$container_file = "containerfiles/$container_name"
$container_owner = "mmontuori"

if ( $args.length -lt 1 ) {
    Write-Output "usage: .\build.ps1 {container name} [container tag]"
    Exit 1
}

$path = Test-Path "$container_file"

if ( $path -eq $false ) {
    Write-Error "Error! cannot find container file $container_file..." 
    Exit 1
}

if ( $null -ne $args[1] ) {
    $docker_tag = $args[1]
} else {
    $docker_tag = "latest"
}

Write-Output "building ${container_owner}/${container_name} with tag:${docker_tag}"

$command = "docker build --file $container_file -t ${container_owner}/${container_name}:${docker_tag} ."

Invoke-Expression "$command"