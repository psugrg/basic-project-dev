# Basic Devcontainer Setup

A minimal, reusable Docker devcontainer template for building consistent development environments.

## Features

- **VS Code Integration**: Ready to use with the Dev Containers extension.
- **Rootless Support**: Configured with a dedicated `devuser`.
- **SSH/Git Support**: Automatically mounts `.gitconfig` and handles `SSH_AUTH_SOCK`.
- **Multi-stage Build**: Includes `development` and `production` stages.

## Quick Start (VS Code)

1. Open this folder in VS Code.
2. Ensure the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) is installed.
3. Click the green button in the bottom-left corner and select **Reopen in Container**.

## Manual Usage

### Devcontainer CLI

```bash
devcontainer up --workspace-folder .
devcontainer exec --workspace-folder . bash
```

### Docker Compose

```bash
docker compose -f .devcontainer/compose.yaml build
docker compose -f .devcontainer/compose.yaml up -d
docker compose -f .devcontainer/compose.yaml exec my-application bash
```

## Production Stage

To build and run the production image:

```bash
docker build --target production -t my-app -f .devcontainer/Dockerfile .
docker run --rm my-app
```

Or via Docker Compose:

```bash
docker compose -f .devcontainer/compose.yaml build my-application --build-arg target=production
docker compose -f .devcontainer/compose.yaml up my-application
```

## Structure

- `.devcontainer/`: Container configuration (Dockerfile, compose.yaml, devcontainer.json).
- `src/`: Project source code (includes `example.sh` script).

## License

[MIT](LICENSE)
