{{/* Labels standards */}}
{{- define "genai.labels" -}}
app: {{ .Chart.Name }}
version: {{ .Chart.Version }}
environment: {{ .Values.global.environment }}
deployment: {{ .Values.global.isCloud | ternary "cloud" "local" }}
{{- end -}}

{{/* Sélecteur d'image intelligent */}}
{{- define "genai.image" -}}
{{- $service := .service -}}
{{- $root := .root -}}
{{- $config := index $root.Values.images $service -}}

{{- if $root.Values.global.isCloud }}
{{- /* Cloud: utilise le repository complet */}}
{{- $config.repository }}:{{ $config.tag | default "latest" }}
{{- else }}
{{- /* Local: utilise le nom simple + tag local */}}
{{- $config.repository }}:{{ $config.tag | default "local" }}
{{- end }}
{{- end -}}

{{/* Détection automatique du contexte */}}
{{- define "genai.isCloud" -}}
{{- if .Values.global.isCloud -}}
true
{{- else -}}
false
{{- end -}}
{{- end -}}
