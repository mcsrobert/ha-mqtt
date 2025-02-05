{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains app name it will be used as a full name.
*/}}
{{- define "mosquitto.fullname" -}}
{{- $fullNameOverride := .Values.mosquitto.fullnameOverride -}}
{{- if $fullNameOverride }}
{{- $fullNameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name "mosquitto" | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "mosquitto.labels" -}}
helm.sh/chart: {{ include "homeassistant-mqtt.chart" . }}
{{ include "mosquitto.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "mosquitto.selectorLabels" -}}
app.kubernetes.io/name: "mosquitto"
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "mosquitto.serviceAccountName" -}}
{{- with .Values.mosquitto.serviceAccount }}
{{- if .create }}
{{- default (include "mosquitto.fullname" $) .name }}
{{- else }}
{{- default "default" .name }}
{{- end }}
{{- end }}
{{- end }}
