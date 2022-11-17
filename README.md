# Michael Kors Data Layer Docs

Deploys data layer docs to GitHub pages.

## Local setup

### Docker (recommended)
1. Have Docker installed
2. Pull the Docker image
  ```shell
  docker pull ghcr.io/tyssejc/mkdocs-material
  ```
3. Run it
  ```shell
  docker run --rm -it -p 8080:8080 -v ${PWD}:/docs tyssejc/mkdocs-material
  ```

### Python
1. Install the mkdocs-material package
  ```shell
  pip install mkdocs-material
  ```
2. Run `mkdocs serve`
