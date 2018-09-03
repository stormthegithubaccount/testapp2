{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create databaseHost
*/}}
{{- define "databaseHost" -}}
{{- if $.Values.mysql.host -}}
  {{- $.Values.mysql.host -}}
{{ else }}
  {{- $.Release.Name -}}-{{- "mysql" -}}
{{ end }}
{{- end -}}


{{/*
Create databaseUrl from MYSQL_HOST, MYSQL_PORT, MYSQL_DATABASE, MYSQL_USER and MYSQL_PASSWORD
*/}}
{{- define "databaseUrl" -}}
  mysql://{{- $.Values.mysql.mysqlUser -}}:{{- $.Values.mysql.mysqlPassword -}}@{{- template "databaseHost" . -}}:{{- $.Values.mysql.port -}}/{{- $.Values.mysql.mysqlDatabase -}}
{{- end -}}


{{/*
Create redisHost
*/}}
{{- define "redisMasterHost" -}}
  redis://{{ $.Release.Name }}-redis-master
{{- end -}}

{{- define "redisSlaveHost" -}}
  redis://{{ $.Release.Name }}-redis-slave
{{- end -}}


{{/*
Return enabled or disaled string
*/}}
{{- define "isEnabled" -}}
{{- if eq . "enabled" -}}
  {{- "enabled" -}}
{{ else }}
  {{- "disabled" -}}
{{ end }}
{{- end -}}