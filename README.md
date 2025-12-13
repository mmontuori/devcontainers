# Dev Containers

create a file called **".env"**. Use the file **env.sample** to start. Or run **createenv.sh** script to interactively create .env file.

This projects hosts developer container I use for different functions. GITHUB Actions are present to publish the images to [https://hub.docker.com/u/mmontuori].

Check the **containerfiles** directory to see the different containers built.

File structure:
```
.
├── build.ps1 (use this to build the containers in Windows)
├── build.sh (use this to build the containers in Linux)
├── containerfiles (the actual Containerfiles)
│   ├── aienv
│   ├── aienv-wsl
│   ├── android-docker
│   ├── ansibleenv
│   ├── cppenv
│   ├── files
│   │   └── jupyter-notebook.sh
│   ├── goenv
│   ├── javaenv
│   ├── kubedev
│   ├── osbase
│   ├── pythonenv
│   └── toolbox
├── createenv.sh (script to aide in creating .env file)
├── env.sample (sample .env file to configure the environment)
├── exec.sh (use this to attach to a running container)
├── export_volume.sh (export content of the persistent volume)
├── files (various files referenced by the containers)
│   ├── ansiblelintwrapper
│   ├── pip.conf
│   └── pylintwrapper
├── import_volume.sh (import a directory into the persistent volume)
├── push.ps1 (push container images to a registry in Windows)
├── push.sh (push container images to a registry in Linux)
├── run.ps1 (run a container image in Windows)
├── run.sh (run a container image in Linux)
└── setenv.sh (set environment script to source in)
```

While this is a project I used for my purposes, suggextions are always welcomed. Please feel free to either email me or post an issue.
