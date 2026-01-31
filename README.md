# release-cleaner Helm Chart

[release-cleaner](https://github.com/devops-ia/helm-release-cleaner) is a Helm chart to clean up Helm releases installed in declared namespaces.

## Usage

Charts are available in:

* [Chart Repository](https://helm.sh/docs/topics/chart_repository/)
* [OCI Artifacts](https://helm.sh/docs/topics/registries/)

### Chart Repository

#### Add repository

```console
helm repo add release-cleaner https://devops-ia.github.io/helm-release-cleaner
helm repo update
```

#### Install Helm chart

```console
helm install [RELEASE_NAME] release-cleaner/release-cleaner
```

This install all the Kubernetes components associated with the chart and creates the release.

_See [helm install](https://helm.sh/docs/helm/helm_install/) for command documentation._

### OCI Registry

Charts are also available in OCI format. The list of available charts can be found [here](https://github.com/devops-ia/helm-release-cleaner/pkgs/container/helm-release-cleaner%2Frelease-cleaner).

#### Install Helm chart

```console
helm install [RELEASE_NAME] oci://ghcr.io/devops-ia/helm-release-cleaner/release-cleaner --version=[version]
```

## release-cleaner chart

Can be found in [release-cleaner chart](charts/release-cleaner).
