{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains app name it will be used as a full name.
*/}}
{{- define "zigbee2mqtt.fullname" -}}
{{- $fullNameOverride := .Values.zigbee2mqtt.fullnameOverride -}}
{{- if $fullNameOverride }}
{{- $fullNameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name "zigbee2mqtt" | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "zigbee2mqtt.labels" -}}
helm.sh/chart: {{ include "homeassistant-mqtt.chart" . }}
{{ include "zigbee2mqtt.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "zigbee2mqtt.selectorLabels" -}}
app.kubernetes.io/name: "zigbee2mqtt"
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "zigbee2mqtt.serviceAccountName" -}}
{{- with .Values.zigbee2mqtt.serviceAccount }}
{{- if .create }}
{{- default (include "zigbee2mqtt.fullname" $) .name }}
{{- else }}
{{- default "default" .name }}
{{- end }}
{{- end }}
{{- end }}
