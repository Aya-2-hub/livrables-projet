{{/*
Détection automatique de la classe de stockage
*/}}
{{- define "gen-ai-app.storageClass" -}}
{{- $provider := .Values.global.cloudProvider | default "standard" -}}
{{- $storageClasses := dict 
  "aws" "gp3" 
  "azure" "managed-premium" 
  "gcp" "standard" 
  "digitalocean" "do-block-storage" 
  "standard" "standard" -}}
{{- index $storageClasses $provider -}}
{{- end -}}

{{/*
Génération du nom complet
*/}}
{{- define "gen-ai-app.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Configuration environnementale automatique
*/}}
{{- define "gen-ai-app.environmentConfig" -}}
{{- $env := .Values.global.environment -}}
{{- $config := dict 
  "dev" (dict "replicas" 1 "resources" (dict "memory" "256Mi" "cpu" "100m"))
  "staging" (dict "replicas" 2 "resources" (dict "memory" "512Mi" "cpu" "250m")) 
  "prod" (dict "replicas" 3 "resources" (dict "memory" "1Gi" "cpu" "500m")) -}}
{{- index $config $env -}}
{{- end -}}