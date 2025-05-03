# release-cleaner

Docker image with helm binary to use by helm-release-cleaner Helm Chart.

```bash
FROM docker.io/alpine:3.12

RUN apk update && \
    apk add coreutils \
            curl      \
            bash      \
            openssl

RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 && \
    chmod 700 get_helm.sh                                                                         && \
    ./get_helm.sh

```
