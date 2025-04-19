$container_name = $args[0]
$container_file = "containerfiles/$container_name"
$container_owner = "mmontuori"

if ( $args.length -lt 1 ) {
    Write-Output "usage: .\build.ps1 {container name} [container tag]"
    Write-Output "Available containers:"
    $container_files = Get-ChildItem -Path containerfiles
    $container_files | ForEach-Object { Write-Output $_.Name }
    Exit 1
}

if ( !( docker login ) ) {
    Write-Error "Error! cannot login to docker..." 
    Exit 1
}

Write-Output "pushing ${container_owner}/${container_name} with tag:latest"

docker push ${container_owner}/${container_name}:latest
