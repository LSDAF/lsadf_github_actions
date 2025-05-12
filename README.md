# GitHub Actions for LSDAF

This repository contains GitHub Actions workflows for managing Docker images for the LSDAF organization.

## Workflows

### 🐳 Build and Push Docker Image by SHA

This workflow builds and pushes a Docker image to GitHub Container Registry (ghcr.io) based on a specific Git commit SHA.

#### Access Control

The workflow implements strict access control:
- Only organization admins can push images
- Organization maintainers and regular members are blocked with specific error messages
- The workflow verifies that the specified Git commit SHA exists
- The workflow checks that the Dockerfile exists before attempting to build

#### Usage

To use this workflow:

1. Go to the Actions tab in the repository
2. Select "🐳 Build and Push Docker Image by SHA"
3. Click "Run workflow"
4. Enter the following parameters:
   - **Git SHA commit to build**: The Git commit SHA or tag to build the image from
   - **GitHub Personal Access Token**: A GitHub Personal Access Token with `read:org` and `write:packages` permissions
   - **Tag the image as latest** (optional): Boolean flag to determine whether to also tag the image as "latest"
   - **Additional tags** (optional): Semicolon-separated list of additional tags to apply to the image (e.g., "v1.0;stable;production"). If empty, only the Git SHA will be used as a tag.

#### Error Handling

The workflow will fail with specific error messages in the following cases:
- If the user is not an organization admin
- If the specified Git commit SHA doesn't exist
- If the Dockerfile doesn't exist at the expected location (docker/Dockerfile)

### 🗑️ Delete Docker Image

This workflow deletes a Docker image from GitHub Container Registry (ghcr.io) based on a specific tag.

#### Access Control

The workflow implements strict access control:
- Only organization admins can delete images
- Organization maintainers and regular members are blocked with specific error messages
- The workflow verifies that the specified image exists before attempting to delete it

#### Usage

To use this workflow:

1. Go to the Actions tab in the repository
2. Select "🗑️ Delete Docker Image"
3. Click "Run workflow"
4. Enter the following parameters:
   - **Tag of the image to delete**: The tag of the image to delete (e.g., a Git SHA)
   - **GitHub Personal Access Token**: A GitHub Personal Access Token with `read:org` and `delete:packages` permissions

#### Error Handling

The workflow will fail with specific error messages in the following cases:
- If the user is not an organization admin
- If the specified image doesn't exist

## Required Permissions

To use these workflows, you need:
- For building and pushing images: Organization admin role and a GitHub Personal Access Token with `read:org` and `write:packages` permissions
- For deleting images: Organization admin role and a GitHub Personal Access Token with `read:org` and `delete:packages` permissions

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.
