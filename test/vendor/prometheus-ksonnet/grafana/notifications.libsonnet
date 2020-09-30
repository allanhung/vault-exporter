{
  local configMap = $.core.v1.configMap,

  /*
    to add a notification channel:

    grafanaNotificationChannels+:: {
      'my-notification-channel.yml': grafana_add_notification_channel('my-email', 'email', 'my-email', 1, true, true, '1h', false, {addresses: 'me@example.com'}),
    }
    See https://grafana.com/docs/administration/provisioning/#alert-notification-channels
  */
  grafanaNotificationChannels+:: {},

  grafana_add_notification_channel(name, type, uid, org_id, settings, is_default=false, send_reminders=true, frequency='1h', disable_resolve_message=false)::
    $.util.manifestYaml({
      notifiers: [
        {
          name: name,
          type: type,
          uid: uid,
          org_id: org_id,
          is_default: is_default,
          send_reminders: send_reminders,
          frequency: frequency,
          disable_resolve_message: disable_resolve_message,
          settings: settings,
        },
      ],
    }),

  notification_channel_config_map:
    configMap.new('grafana-notification-channels') +
    configMap.withDataMixin({
      [name]: std.toString($.grafanaNotificationChannels[name])
      for name in std.objectFields($.grafanaNotificationChannels)
    }) +
    configMap.mixin.metadata.withLabels($._config.grafana_notification_channel_labels),
}
