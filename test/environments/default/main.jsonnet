local prometheus = (import "prometheus-ksonnet/prometheus-ksonnet.libsonnet");
local vault = (import "vault-mixin/mixin.libsonnet");

vault {
  jobs+: {
    vault: "vault/example",
  },
}
