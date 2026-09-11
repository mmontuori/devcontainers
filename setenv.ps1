# copy this file to .env, uncomment, and set the variables below
# to customize the container settings
#
# $use_gpus=
# $container_name="devcontainer"
$container_runtime="docker"
# $label="label"
# $container_user="devuser"
# $container_port="8888"
$dev_volume="c:/Users/v726/workspace"



if ( $label -eq $null ) {
    $label="mmontuori"
}

if ( $container_runtime -eq $null ) {
    $container_runtime="podman"
}

if ( $container_user -eq $null ) {
    $container_user="devuser"
}

if ( $container_port -ne $null ) {
    $container_args="-p${container_port}:${container_port}"
}

if ( $use_gpus -ne $null ) {
    $gpu_args="--gpus=all"
}

if ( $dev_volume -eq $null ) {
    $dev_volume="devvol"
}

if ( $container_name -eq $null ) {
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
