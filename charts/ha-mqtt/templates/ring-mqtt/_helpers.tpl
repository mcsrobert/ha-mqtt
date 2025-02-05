{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains app name it will be used as a full name.
*/}}
{{- define "ringMqtt.fullname" -}}
{{- $fullNameOverride := .Values.ringMqtt.fullnameOverride -}}
{{- if $fullNameOverride }}
{{- $fullNameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name "ring-mqtt" | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "ringMqtt.labels" -}}
helm.sh/chart: {{ include "homeassistant-mqtt.chart" . }}
{{ include "ringMqtt.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "ringMqtt.selectorLabels" -}}
app.kubernetes.io/name: "ring-mqtt"
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "ringMqtt.serviceAccountName" -}}
{{- with .Values.ringMqtt.serviceAccount }}
{{- if .create }}
{{- default (include "ringMqtt.fullname" $) .name }}
{{- else }}
{{- default "default" .name }}
{{- end }}
{{- end }}
{{- end }}
