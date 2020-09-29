{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "labels.common" -}}
{{ include "labels.selector" . }}
chart: {{ include "chart" . | quote }}
heritage: {{ .Release.Service | quote }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "labels.selector" -}}
app: {{ include "name" . | quote }}
release: {{ .Release.Name | quote }}
{{- end -}}
