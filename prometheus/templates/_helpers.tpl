{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "prometheus.name" -}}
{{- default "prometheus" .Values.prometheusNameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "alertmanager.name" -}}
{{- default "alertmanager" .Values.alertmanagerNameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "prometheus.fullname" -}}
{{- $name := default "prometheus" .Values.prometheusNameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "alertmanager.fullname" -}}
{{- $name := default "alertmanager" .Values.alertmanagerNameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
