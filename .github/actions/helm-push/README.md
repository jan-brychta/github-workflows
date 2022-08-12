# Helm push action

Action for packaging Helm chart and publishing it to a registry.

## Usage

### `workflow.yml` Example

Place in a `.yml` file such as this one in your `.github/workflows` folder. [Refer to the documentation on workflow YAML syntax here.](https://help.github.com/en/articles/workflow-syntax-for-github-actions)

```yaml
name: Build & Push Helm chart
on:
  push:
    branches: 
    - "main"
    paths:
     - charts/chart_name/**

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: ./.github/actions/helm-push
        env:
        CHART_NAME: 'standard-service'
        WORKING_DIRECTORY: './charts'
        IMAGEHUB_URL: 'https://imagehub.ehealth.exchange/chartrepo/sitka-helm-charts'
        IMAGEHUB_USERNAME: '${{ secrets.IMAGEHUB_USERNAME}}'
        IMAGEHUB_PASSWORD: '${{ secrets.IMAGEHUB_PASSWORD}}'
```

### Configuration

The following settings must be passed as environment variables as shown in the example. Sensitive information, especially `IMAGEHUB_PASSWORD`, should be [set as encrypted secrets](https://help.github.com/en/articles/virtual-environments-for-github-actions#creating-and-using-secrets-encrypted-variables) — otherwise, they'll be public to anyone browsing your repository.

| Key | Value | Suggested Type | Required | Default |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| `CHART_NAME` | Folder with chart in repo | `env` | **Yes** | null |
| `WORKING_DIRECTORY` | Folder with Helm charts | `env` | No | ./charts |
| `IMAGEHUB_URL` | Imagehub repository url  | `env` | No | https://imagehub.ehealth.exchange/chartrepo/sitka-helm-charts |
| `IMAGEHUB_USERNAME` | Username for Imagehub | `env` | **Yes** | null |
| `IMAGEHUB_PASSWORD` | Password for Imagehub | `secret` | No | null |

## Action versions

-  helm v3.9.0
-  helm cm-push v0.10.3
