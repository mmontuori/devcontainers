$container_name = $args[0]
$container_owner = "mmontuori"
$container_user = "devuser"

if ( $args.length -lt 1 ) {
    Write-Output "usage: .\build.ps1 {container name} [container tag]"
    Exit 1
}

if ( $null -ne $args[1] ) {
    $docker_tag = $args[1]
} else {
    $docker_tag = "latest"
}

Write-Output "running ${container_owner}/${container_name} with tag:${docker_tag}"

$command = "docker run -ti --rm --user $container_user ${container_owner}/${container_name}:${docker_tag} /bin/bash"

Invoke-Expression "$command"