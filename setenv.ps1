. .env.ps1

if ( $null -eq $label ) {
    $label="mmontuori"
}

if ( $null -eq $container_runtime ) {
    $container_runtime="podman"
}

if ( $null -eq $container_user ) {
    $container_user="devuser"
}

if ( $null -ne $container_port ) {
    $container_args="-p${container_port}:${container_port}"
}

if ( $null -ne $use_gpus ) {
    $gpu_args="--gpus=all"
}

if ( $null -eq $dev_volume ) {
    $dev_volume="devvol"
}

if ( $null -eq $container_name ) {
    $container_name="devcontainer"
}

Write-Output "Environment"
Write-Output "========================================"
Write-Output "| use_gpus=${use_gpus}"
Write-Output "| container_runtime=${container_runtime}"
Write-Output "| container_name=${container_name}"
Write-Output "| label=${label}"
Write-Output "| container_user=${container_user}"
Write-Output "| container_port=${container_port}"
Write-Output "| dev_volume=${dev_volume}"
Write-Output "========================================"
