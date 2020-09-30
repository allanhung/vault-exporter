local grafana = import 'grafana-builder/grafana.libsonnet';
local dashboard = grafana.dashboard;
local template = grafana.template;
local singlestat = grafana.singlestat;
local prometheus = grafana.prometheus;

dashboard.new(
  'Test',
  schemaVersion=16,
)
.addTemplate(
  grafana.template.datasource(
    'PROMETHEUS_DS',
    'prometheus',
    'Prometheus',
    hide='label',
  )
)
.addPanel(
  singlestat.new(
    'prometheus-up',
    format='s',
    datasource='Prometheus',
    span=2,
    valueName='current',
  )
  .addTarget(
    prometheus.target(
      'up{job="prometheus"}',
    )
  ), 
  gridPos= { x: 0, y: 0, w: 24, h: 3, }
)
