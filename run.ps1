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

if ( $null -eq $container_name ) {
    Write-Output "usage: .\run.ps1 {container name} [container tag]"
    Write-Output "   -container_name [container name]"
    Write-Output "   -tag [container tag] (default: latest)"
    Write-Output "   -container_owner [container owner] (default: mmontuori)"
    Write-Output "   -container_user [container user] (default: devuser)"
    Write-Output "   -work_directory [work directory] (default: ${env:USERPROFILE})"
    Write-Output "   -help (this message)"
    Write-Output ""
    ListContainerFiles
    Exit 1
}

Write-Output "running ${container_owner}/${container_name} with tag:${tag}"

$command = "${container_runtime} run --detach -ti --rm --user ${container_user}:devgroup -v ${dev_volume}:/home/${container_user} ${label}/${container_name} /bin/zsh"

Invoke-Expression "$command"