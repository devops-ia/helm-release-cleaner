# release-cleaner

A Helm chart to clean up Helm releases installed in declared namespaces

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| amartingarcia | <adrianmg231189@gmail.com> | <https://github.com/amartingarcia> |
| ialejandro | <hello@ialejandro.rocks> | <https://ialejandro.rocks> |

## Prerequisites

* Helm 3+

## Add repository

```console
helm repo add release-cleaner https://devops-ia.github.io/helm-release-cleaner
helm repo update
```

## Install Helm chart (repository mode)

```console
helm install [RELEASE_NAME] release-cleaner/release-cleaner
```

This install all the Kubernetes components associated with the chart and creates the release.

_See [helm install](https://helm.sh/docs/helm/helm_install/) for command documentation._

## Install Helm chart (OCI mode)

Charts are also available in OCI format. The list of available charts can be found [here](https://github.com/devops-ia/helm-release-cleaner/pkgs/container/helm-release-cleaner%2Frelease-cleaner).

```console
helm install [RELEASE_NAME] oci://ghcr.io/devops-ia/helm-release-cleaner/release-cleaner --version=[version]
```

## Uninstall Helm chart

```console
helm uninstall [RELEASE_NAME]
```

This removes all the Kubernetes components associated with the chart and deletes the release.

_See [helm uninstall](https://helm.sh/docs/helm/helm_uninstall/) for command documentation._

## Configuration

See [Customizing the chart before installing](https://helm.sh/docs/intro/using_helm/#customizing-the-chart-before-installing). To see all configurable options with comments:

```console
helm show values release-cleaner/release-cleaner
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Affinity for pod assignment </br> Ref: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity |
| cronjob | object | `{"backoffLimit":6,"concurrencyPolicy":"Replace","failedJobsHistoryLimit":2,"restartPolicy":"Never","successfulJobsHistoryLimit":10,"suspend":false}` | CronJob configuration |
| cronjob.backoffLimit | int | `6` | Specifies the number of retries before marking job as failed |
| cronjob.concurrencyPolicy | string | `"Replace"` | Specifies how to treat concurrent executions of a Job |
| cronjob.failedJobsHistoryLimit | int | `2` | The number of failed finished jobs to retain |
| cronjob.restartPolicy | string | `"Never"` | Restart policy for all containers within the Pod |
| cronjob.successfulJobsHistoryLimit | int | `10` | The number of successful finished jobs to retain |
| cronjob.suspend | bool | `false` | Suspend the CronJob |
| dnsConfig | object | `{}` | Configure DNS </br> Ref: https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/ |
| dnsPolicy | string | `"ClusterFirst"` | Configure DNS policy Options: ClusterFirst, Default, ClusterFirstWithHostNet, None </br> Ref: https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/ |
| env | object | `{}` | Environment variables to configure application |
| envFromConfigMap | object | `{}` | Variables from configMap |
| envFromSecrets | object | `{}` | Variables from secrets |
| extraObjects | list | `[]` | Extra Kubernetes manifests to deploy |
| fullnameOverride | string | `""` | String to fully override release-cleaner.fullname template |
| image | object | `{"pullPolicy":"IfNotPresent","repository":"alpine/helm","tag":""}` | Image registry The image configuration for the base service |
| imagePullSecrets | list | `[]` | Docker registry secret names as an array |
| nameOverride | string | `""` | String to partially override release-cleaner.fullname template (will maintain the release name) |
| namespacesClean | string | `"default"` | Text string with the namespace names where the cleaner will work If none is specified, by default it will be executed in the default namespace Example: "default, monitoring" |
| networkPolicy | object | `{"egress":[],"enabled":false,"ingress":[],"policyTypes":[]}` | NetworkPolicy configuration </br> Ref: https://kubernetes.io/docs/concepts/services-networking/network-policies/ |
| networkPolicy.enabled | bool | `false` | Enable or disable NetworkPolicy |
| networkPolicy.policyTypes | list | `[]` | Policy types |
| nodeSelector | object | `{}` | Node labels for pod assignment </br> Ref: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector |
| podAnnotations | object | `{}` | Configure annotations on Pods |
| podLabels | object | `{}` | Configure labels on Pods |
| podSecurityContext | object | `{}` | Defines privilege and access control settings for a Pod </br> Ref: https://kubernetes.io/docs/concepts/security/pod-security-standards/ </br> Ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/ |
| releasesExclude | object | `{"enabled":false,"releases":["my-release"]}` | Exclusion of releases List of releases to be excluded by the cleaner |
| resources | object | `{}` | Resources limits and requested </br> Ref: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/ |
| schedule | string | `"5 * * * *"` | CronJob schedule </br> Ref: https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/ |
| securityContext | object | `{}` | Defines privilege and access control settings for a Container </br> Ref: https://kubernetes.io/docs/concepts/security/pod-security-standards/ </br> Ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/ |
| serviceAccount | object | `{"annotations":{},"automount":true,"create":true,"name":""}` | Enable creation of ServiceAccount </br> Ref: https://kubernetes.io/docs/concepts/security/service-accounts/ |
| tolerations | list | `[]` | Tolerations for pod assignment </br> Ref: https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/ |
| topologySpreadConstraints | list | `[]` | Control how Pods are spread across your cluster </br> Ref: https://kubernetes.io/docs/concepts/scheduling-eviction/topology-spread-constraints/#example-multiple-topologyspreadconstraints |
| volumeMounts | list | `[]` | Additional volumeMounts on the output CronJob definition |
| volumes | list | `[]` | Additional volumes on the output CronJob definition </br> Ref: https://kubernetes.io/docs/concepts/storage/volumes/ |
