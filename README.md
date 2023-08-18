# Docker Based Development Environment - Basic Example

The basic example of the *all-in-one* development environment based on [Docker](www.docker.com) and [Docker Compose](https://docs.docker.com/compose/).

It can be used as a starting point for *any* project that requires a build environment.

## Architecture

This *basic example project* contains two modules: *base image* and *user image*. First one is used to create an image that contain all tools and dependencies but without a user and a mounted project. Second one is used to add a user and mount a folder with the project.

> Inspiration:
[1](https://jtreminio.com/blog/running-docker-containers-as-current-host-user/),
[2](https://medium.com/redbubble/running-a-docker-container-as-a-non-root-user-7d2e00f8ee15),
[3](https://vsupalov.com/docker-shared-permissions/),
[4](https://medium.com/faun/set-current-host-user-for-docker-container-4e521cef9ffc).

### Base Image

The `dev/` directory contains the *base image* that holds the definition of the actual build system.

The docker image is define in the *Dockerfile* and corresponding *docker-compose.yaml* file contains the build rules.

This module creates the development environment that contains all tools and elements that are required by the project such as: compiler, debugger, libraries etc.

> The compiled docker image can be uploaded to the repository that holds all released versions of the development environment. This way a developer can just download pre-build version of the development environment without the need of building it himself.

### User Image

The top level project directory contains the *Dockerfile* and corresponding *docker-compose.yaml* file that defines the docker image deriving from the *base image*. It creates a user and mounts the current directory containing the project.

> This image should be created manually by each developer in order to create usable development environment.

## Usage

The process is spit into two parts: *creating base image* and *creating user image*.

### Creating Base Image

Prepare the development environment by changing the *Dockerfile* and *docker-compose.yaml* file.

> Remember to update the version of the *docker image*.

Execute the following command from the `dev/` directory:

```bash
docker compose build
```

At this point the `base image` may be uploaded to the repository or used locally by the next step (Creating User Image).

> This step should be done always when there's a need of adding something to the *development environment*.

### Creating User Image

Execute the following command from the top level project directory:

```bash
docker compose build \
    --build-arg  USER_ID=$(id -u ${user}) \
    --build-arg GROUP_ID=$(id -g ${user}) \
&& docker compose up -d
```

This command will use the *base image* to create a dedicated version of the *development environment* for the current user.

> This step should be performed always when there's a change in the *base image*.
