{{/*
Expand the name of the chart.
*/}}
{{- define "release-cleaner.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "release-cleaner.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "release-cleaner.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "release-cleaner.labels" -}}
helm.sh/chart: {{ include "release-cleaner.chart" . }}
{{ include "release-cleaner.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "release-cleaner.selectorLabels" -}}
app.kubernetes.io/name: {{ include "release-cleaner.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "release-cleaner.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "release-cleaner.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Ref: https://github.com/aws/karpenter-provider-aws/blob/main/charts/karpenter/templates/_helpers.tpl
Patch the label selector on an object
This template will add a labelSelector using matchLabels to the object referenced at _target if there is no labelSelector specified.
The matchLabels are created with the selectorLabels template.
This works because Helm treats dictionaries as mutable objects and allows passing them by reference.
*/}}
{{- define "release-cleaner.patchSelectorLabels" -}}
{{- if not (hasKey ._target "labelSelector") }}
{{- $selectorLabels := (include "release-cleaner.selectorLabels" .) | fromYaml }}
{{- $_ := set ._target "labelSelector" (dict "matchLabels" $selectorLabels) }}
{{- end }}
{{- end }}

{{/*
Ref: https://github.com/aws/karpenter-provider-aws/blob/main/charts/karpenter/templates/_helpers.tpl
Patch topology spread constraints
This template uses the release-cleaner.selectorLabels template to add a labelSelector to topologySpreadConstraints if one isn't specified.
This works because Helm treats dictionaries as mutable objects and allows passing them by reference.
*/}}
{{- define "release-cleaner.patchTopologySpreadConstraints" -}}
{{- range $constraint := .Values.topologySpreadConstraints }}
{{- include "release-cleaner.patchSelectorLabels" (merge (dict "_target" $constraint (include "release-cleaner.selectorLabels" $)) $) }}
{{- end }}
{{- end }}
