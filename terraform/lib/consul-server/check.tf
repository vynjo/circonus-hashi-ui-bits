resource "circonus_check" "consul" {
  name   = "Consul Check: ${var.hostname}"
  notes  = "Check that Consul emits its metrics to"
  period = "60s"

  collector {
    id = "${var.collector_id}"
  }

  httptrap {
    secret = "${var.secret}"
  }

  tags = ["${var.consul_tags}", "host:${var.hostname}"]

  target = "${var.hostname}"

  metric {
    name = "${circonus_metric.consul-session-ttl-active.name}"
    tags = ["${circonus_metric.consul-session-ttl-active.tags}"]
    type = "${circonus_metric.consul-session-ttl-active.type}"
  }

  metric {
    name = "${circonus_metric.memberlist-health-score.name}"
    tags = ["${circonus_metric.memberlist-health-score.tags}"]
    type = "${circonus_metric.memberlist-health-score.type}"
  }

  metric {
    name = "${circonus_metric.runtime-alloc-bytes.name}"
    tags = ["${circonus_metric.runtime-alloc-bytes.tags}"]
    type = "${circonus_metric.runtime-alloc-bytes.type}"
    unit = "${circonus_metric.runtime-alloc-bytes.unit}"
  }

  metric {
    name = "${circonus_metric.runtime-free-count.name}"
    tags = ["${circonus_metric.runtime-free-count.tags}"]
    type = "${circonus_metric.runtime-free-count.type}"
  }

  metric {
    name = "${circonus_metric.runtime-heap-objects.name}"
    tags = ["${circonus_metric.runtime-heap-objects.tags}"]
    type = "${circonus_metric.runtime-heap-objects.type}"
  }

  metric {
    name = "${circonus_metric.runtime-malloc-count.name}"
    tags = ["${circonus_metric.runtime-malloc-count.tags}"]
    type = "${circonus_metric.runtime-malloc-count.type}"
  }

  metric {
    name = "${circonus_metric.runtime-num-goroutines.name}"
    tags = ["${circonus_metric.runtime-num-goroutines.tags}"]
    type = "${circonus_metric.runtime-num-goroutines.type}"
  }

  metric {
    name = "${circonus_metric.runtime-sys-bytes.name}"
    tags = ["${circonus_metric.runtime-sys-bytes.tags}"]
    type = "${circonus_metric.runtime-sys-bytes.type}"
    unit = "${circonus_metric.runtime-sys-bytes.unit}"
  }

  metric {
    name = "${circonus_metric.runtime-total-gc-pause.name}"
    tags = ["${circonus_metric.runtime-total-gc-pause.tags}"]
    type = "${circonus_metric.runtime-total-gc-pause.type}"
    unit = "${circonus_metric.runtime-total-gc-pause.unit}"
  }

  metric {
    name = "${circonus_metric.runtime-total-gc-runs.name}"
    tags = ["${circonus_metric.runtime-total-gc-runs.tags}"]
    type = "${circonus_metric.runtime-total-gc-runs.type}"
  }

  metric {
    name = "${circonus_metric.catalog-deregister.name}"
    tags = ["${circonus_metric.catalog-deregister.tags}"]
    type = "${circonus_metric.catalog-deregister.type}"
  }

  metric {
    name = "${circonus_metric.catalog-register.name}"
    tags = ["${circonus_metric.catalog-register.tags}"]
    type = "${circonus_metric.catalog-register.type}"
  }

  metric {
    name = "${circonus_metric.consul-fsm-coordinate-batch-update.name}"
    tags = ["${circonus_metric.consul-fsm-coordinate-batch-update.tags}"]
    type = "${circonus_metric.consul-fsm-coordinate-batch-update.type}"
  }

  metric {
    name = "${circonus_metric.consul-fsm-deregister.name}"
    tags = ["${circonus_metric.consul-fsm-deregister.tags}"]
    type = "${circonus_metric.consul-fsm-deregister.type}"
  }

  metric {
    name = "${circonus_metric.consul-fsm-kvs-delete.name}"
    tags = ["${circonus_metric.consul-fsm-kvs-delete.tags}"]
    type = "${circonus_metric.consul-fsm-kvs-delete.type}"
  }

  metric {
    name = "${circonus_metric.consul-fsm-kvs-delete-cas.name}"
    tags = ["${circonus_metric.consul-fsm-kvs-delete-cas.tags}"]
    type = "${circonus_metric.consul-fsm-kvs-delete-cas.type}"
  }

  metric {
    name = "${circonus_metric.consul-fsm-kvs-lock.name}"
    tags = ["${circonus_metric.consul-fsm-kvs-lock.tags}"]
    type = "${circonus_metric.consul-fsm-kvs-lock.type}"
  }

  metric {
    name = "${circonus_metric.consul-fsm-kvs-set.name}"
    tags = ["${circonus_metric.consul-fsm-kvs-set.tags}"]
    type = "${circonus_metric.consul-fsm-kvs-set.type}"
  }

  metric {
    name = "${circonus_metric.consul-fsm-kvs-unlock.name}"
    tags = ["${circonus_metric.consul-fsm-kvs-unlock.tags}"]
    type = "${circonus_metric.consul-fsm-kvs-unlock.type}"
  }

  metric {
    name = "${circonus_metric.consul-fsm-persist.name}"
    tags = ["${circonus_metric.consul-fsm-persist.tags}"]
    type = "${circonus_metric.consul-fsm-persist.type}"
  }

  metric {
    name = "${circonus_metric.consul-fsm-register.name}"
    tags = ["${circonus_metric.consul-fsm-register.tags}"]
    type = "${circonus_metric.consul-fsm-register.type}"
  }

  metric {
    name = "${circonus_metric.consul-fsm-session-create.name}"
    tags = ["${circonus_metric.consul-fsm-session-create.tags}"]
    type = "${circonus_metric.consul-fsm-session-create.type}"
  }

  metric {
    name = "${circonus_metric.consul-fsm-session-destroy.name}"
    tags = ["${circonus_metric.consul-fsm-session-destroy.tags}"]
    type = "${circonus_metric.consul-fsm-session-destroy.type}"
  }

  metric {
    name = "${circonus_metric.consul-fsm-tombstone-reap.name}"
    tags = ["${circonus_metric.consul-fsm-tombstone-reap.tags}"]
    type = "${circonus_metric.consul-fsm-tombstone-reap.type}"
  }

  metric {
    name = "${circonus_metric.consul-http-kv-delete.name}"
    tags = ["${circonus_metric.consul-http-kv-delete.tags}"]
    type = "${circonus_metric.consul-http-kv-delete.type}"
  }

  metric {
    name = "${circonus_metric.consul-http-catalog-datacenters.name}"
    tags = ["${circonus_metric.consul-http-catalog-datacenters.tags}"]
    type = "${circonus_metric.consul-http-catalog-datacenters.type}"
  }

  metric {
    name = "${circonus_metric.consul-http-catalog-node.name}"
    tags = ["${circonus_metric.consul-http-catalog-node.tags}"]
    type = "${circonus_metric.consul-http-catalog-node.type}"
  }

  metric {
    name = "${circonus_metric.consul-http-catalog-service.name}"
    tags = ["${circonus_metric.consul-http-catalog-service.tags}"]
    type = "${circonus_metric.consul-http-catalog-service.type}"
  }

  metric {
    name = "${circonus_metric.consul-http-coordinate-nodes.name}"
    tags = ["${circonus_metric.consul-http-coordinate-nodes.tags}"]
    type = "${circonus_metric.consul-http-coordinate-nodes.type}"
  }

  metric {
    name = "${circonus_metric.consul-http-internal-ui-nodes.name}"
    tags = ["${circonus_metric.consul-http-internal-ui-nodes.tags}"]
    type = "${circonus_metric.consul-http-internal-ui-nodes.type}"
  }

  metric {
    name = "${circonus_metric.consul-http-internal-ui-service.name}"
    tags = ["${circonus_metric.consul-http-internal-ui-service.tags}"]
    type = "${circonus_metric.consul-http-internal-ui-service.type}"
  }

  metric {
    name = "${circonus_metric.consul-http-get-kv.name}"
    tags = ["${circonus_metric.consul-http-get-kv.tags}"]
    type = "${circonus_metric.consul-http-get-kv.type}"
  }

  metric {
    name = "${circonus_metric.consul-http-put-kv.name}"
    tags = ["${circonus_metric.consul-http-put-kv.tags}"]
    type = "${circonus_metric.consul-http-put-kv.type}"
  }

  metric {
    name = "${circonus_metric.consul-kvs-apply.name}"
    tags = ["${circonus_metric.consul-kvs-apply.tags}"]
    type = "${circonus_metric.consul-kvs-apply.type}"
  }

  metric {
    name = "${circonus_metric.consul-leader-barrier.name}"
    tags = ["${circonus_metric.consul-leader-barrier.tags}"]
    type = "${circonus_metric.consul-leader-barrier.type}"
  }

  metric {
    name = "${circonus_metric.consul-leader-reap-tombstones.name}"
    tags = ["${circonus_metric.consul-leader-reap-tombstones.tags}"]
    type = "${circonus_metric.consul-leader-reap-tombstones.type}"
  }

  metric {
    name = "${circonus_metric.consul-leader-reconcile.name}"
    tags = ["${circonus_metric.consul-leader-reconcile.tags}"]
    type = "${circonus_metric.consul-leader-reconcile.type}"
  }

  metric {
    name = "${circonus_metric.consul-leader-reconcile-member.name}"
    tags = ["${circonus_metric.consul-leader-reconcile-member.tags}"]
    type = "${circonus_metric.consul-leader-reconcile-member.type}"
  }

  metric {
    name = "${circonus_metric.consul-prepared-query-execute.name}"
    tags = ["${circonus_metric.consul-prepared-query-execute.tags}"]
    type = "${circonus_metric.consul-prepared-query-execute.type}"
  }

  metric {
    name = "${circonus_metric.consul-rpc-accept-conn.name}"
    tags = ["${circonus_metric.consul-rpc-accept-conn.tags}"]
    type = "${circonus_metric.consul-rpc-accept-conn.type}"
  }

  metric {
    name = "${circonus_metric.consul-rpc-consistent-read.name}"
    tags = ["${circonus_metric.consul-rpc-consistent-read.tags}"]
    type = "${circonus_metric.consul-rpc-consistent-read.type}"
  }

  metric {
    name = "${circonus_metric.consul-rpc-query.name}"
    tags = ["${circonus_metric.consul-rpc-query.tags}"]
    type = "${circonus_metric.consul-rpc-query.type}"
  }

  metric {
    name = "${circonus_metric.consul-rpc-raft-handoff.name}"
    tags = ["${circonus_metric.consul-rpc-raft-handoff.tags}"]
    type = "${circonus_metric.consul-rpc-raft-handoff.type}"
  }

  metric {
    name = "${circonus_metric.consul-rpc-request.name}"
    tags = ["${circonus_metric.consul-rpc-request.tags}"]
    type = "${circonus_metric.consul-rpc-request.type}"
  }

  metric {
    name = "${circonus_metric.consul-session-ttl-invalidate.name}"
    tags = ["${circonus_metric.consul-session-ttl-invalidate.tags}"]
    type = "${circonus_metric.consul-session-ttl-invalidate.type}"
  }

  metric {
    name = "${circonus_metric.consul-session-apply.name}"
    tags = ["${circonus_metric.consul-session-apply.tags}"]
    type = "${circonus_metric.consul-session-apply.type}"
  }

  metric {
    name = "${circonus_metric.consul-session-renew.name}"
    tags = ["${circonus_metric.consul-session-renew.tags}"]
    type = "${circonus_metric.consul-session-renew.type}"
  }

  metric {
    name = "${circonus_metric.memberlist-degraded-probe.name}"
    tags = ["${circonus_metric.memberlist-degraded-probe.tags}"]
    type = "${circonus_metric.memberlist-degraded-probe.type}"
  }

  metric {
    name = "${circonus_metric.memberlist-gossip.name}"
    tags = ["${circonus_metric.memberlist-gossip.tags}"]
    type = "${circonus_metric.memberlist-gossip.type}"
  }

  metric {
    name = "${circonus_metric.memberlist-msg-alive.name}"
    tags = ["${circonus_metric.memberlist-msg-alive.tags}"]
    type = "${circonus_metric.memberlist-msg-alive.type}"
  }

  metric {
    name = "${circonus_metric.memberlist-msg-dead.name}"
    tags = ["${circonus_metric.memberlist-msg-dead.tags}"]
    type = "${circonus_metric.memberlist-msg-dead.type}"
  }

  metric {
    name = "${circonus_metric.memberlist-msg-suspect.name}"
    tags = ["${circonus_metric.memberlist-msg-suspect.tags}"]
    type = "${circonus_metric.memberlist-msg-suspect.type}"
  }

  metric {
    name = "${circonus_metric.memberlist-probe-node.name}"
    tags = ["${circonus_metric.memberlist-probe-node.tags}"]
    type = "${circonus_metric.memberlist-probe-node.type}"
  }

  metric {
    name = "${circonus_metric.memberlist-push-pull-node.name}"
    tags = ["${circonus_metric.memberlist-push-pull-node.tags}"]
    type = "${circonus_metric.memberlist-push-pull-node.type}"
  }

  metric {
    name = "${circonus_metric.memberlist-tcp-accept.name}"
    tags = ["${circonus_metric.memberlist-tcp-accept.tags}"]
    type = "${circonus_metric.memberlist-tcp-accept.type}"
  }

  metric {
    name = "${circonus_metric.memberlist-tcp-connect.name}"
    tags = ["${circonus_metric.memberlist-tcp-connect.tags}"]
    type = "${circonus_metric.memberlist-tcp-connect.type}"
  }

  metric {
    name = "${circonus_metric.memberlist-tcp-sent.name}"
    tags = ["${circonus_metric.memberlist-tcp-sent.tags}"]
    type = "${circonus_metric.memberlist-tcp-sent.type}"
  }

  metric {
    name = "${circonus_metric.memberlist-udp-received.name}"
    tags = ["${circonus_metric.memberlist-udp-received.tags}"]
    type = "${circonus_metric.memberlist-udp-received.type}"
  }

  metric {
    name = "${circonus_metric.memberlist-udp-sent.name}"
    tags = ["${circonus_metric.memberlist-udp-sent.tags}"]
    type = "${circonus_metric.memberlist-udp-sent.type}"
  }

  metric {
    name = "${circonus_metric.raft-apply.name}"
    tags = ["${circonus_metric.raft-apply.tags}"]
    type = "${circonus_metric.raft-apply.type}"
  }

  metric {
    name = "${circonus_metric.raft-barrier.name}"
    tags = ["${circonus_metric.raft-barrier.tags}"]
    type = "${circonus_metric.raft-barrier.type}"
  }

  metric {
    name = "${circonus_metric.raft-candidate-elect-self.name}"
    tags = ["${circonus_metric.raft-candidate-elect-self.tags}"]
    type = "${circonus_metric.raft-candidate-elect-self.type}"
  }

  metric {
    name = "${circonus_metric.raft-commit-time.name}"
    tags = ["${circonus_metric.raft-commit-time.tags}"]
    type = "${circonus_metric.raft-commit-time.type}"
  }

  metric {
    name = "${circonus_metric.raft-compact-logs.name}"
    tags = ["${circonus_metric.raft-compact-logs.tags}"]
    type = "${circonus_metric.raft-compact-logs.type}"
  }

  metric {
    name = "${circonus_metric.raft-fsm-apply.name}"
    tags = ["${circonus_metric.raft-fsm-apply.tags}"]
    type = "${circonus_metric.raft-fsm-apply.type}"
  }

  metric {
    name = "${circonus_metric.raft-fsm-restore.name}"
    tags = ["${circonus_metric.raft-fsm-restore.tags}"]
    type = "${circonus_metric.raft-fsm-restore.type}"
  }

  metric {
    name = "${circonus_metric.raft-fsm-snapshot.name}"
    tags = ["${circonus_metric.raft-fsm-snapshot.tags}"]
    type = "${circonus_metric.raft-fsm-snapshot.type}"
  }

  metric {
    name = "${circonus_metric.raft-leader-dispatch-log.name}"
    tags = ["${circonus_metric.raft-leader-dispatch-log.tags}"]
    type = "${circonus_metric.raft-leader-dispatch-log.type}"
  }

  metric {
    name = "${circonus_metric.raft-leader-last-contact.name}"
    tags = ["${circonus_metric.raft-leader-last-contact.tags}"]
    type = "${circonus_metric.raft-leader-last-contact.type}"
  }

  metric {
    name = "${circonus_metric.raft-rpc-append-entries.name}"
    tags = ["${circonus_metric.raft-rpc-append-entries.tags}"]
    type = "${circonus_metric.raft-rpc-append-entries.type}"
  }

  metric {
    name = "${circonus_metric.raft-rpc-append-entries-process-logs.name}"
    tags = ["${circonus_metric.raft-rpc-append-entries-process-logs.tags}"]
    type = "${circonus_metric.raft-rpc-append-entries-process-logs.type}"
  }

  metric {
    name = "${circonus_metric.raft-rpc-append-entries-store-logs.name}"
    tags = ["${circonus_metric.raft-rpc-append-entries-store-logs.tags}"]
    type = "${circonus_metric.raft-rpc-append-entries-store-logs.type}"
  }

  metric {
    name = "${circonus_metric.raft-rpc-install-snapshot.name}"
    tags = ["${circonus_metric.raft-rpc-install-snapshot.tags}"]
    type = "${circonus_metric.raft-rpc-install-snapshot.type}"
  }

  metric {
    name = "${circonus_metric.raft-rpc-process-heartbeat.name}"
    tags = ["${circonus_metric.raft-rpc-process-heartbeat.tags}"]
    type = "${circonus_metric.raft-rpc-process-heartbeat.type}"
  }

  metric {
    name = "${circonus_metric.raft-rpc-request-vote.name}"
    tags = ["${circonus_metric.raft-rpc-request-vote.tags}"]
    type = "${circonus_metric.raft-rpc-request-vote.type}"
  }

  metric {
    name = "${circonus_metric.raft-snapshot-create.name}"
    tags = ["${circonus_metric.raft-snapshot-create.tags}"]
    type = "${circonus_metric.raft-snapshot-create.type}"
  }

  metric {
    name = "${circonus_metric.raft-snapshot-persist.name}"
    tags = ["${circonus_metric.raft-snapshot-persist.tags}"]
    type = "${circonus_metric.raft-snapshot-persist.type}"
  }

  metric {
    name = "${circonus_metric.raft-snapshot-take-snapshot.name}"
    tags = ["${circonus_metric.raft-snapshot-take-snapshot.tags}"]
    type = "${circonus_metric.raft-snapshot-take-snapshot.type}"
  }

  metric {
    name = "${circonus_metric.raft-state-candidate.name}"
    tags = ["${circonus_metric.raft-state-candidate.tags}"]
    type = "${circonus_metric.raft-state-candidate.type}"
  }

  metric {
    name = "${circonus_metric.raft-state-follower.name}"
    tags = ["${circonus_metric.raft-state-follower.tags}"]
    type = "${circonus_metric.raft-state-follower.type}"
  }

  metric {
    name = "${circonus_metric.raft-state-leader.name}"
    tags = ["${circonus_metric.raft-state-leader.tags}"]
    type = "${circonus_metric.raft-state-leader.type}"
  }

  metric {
    name = "${circonus_metric.raft-transition-heartbeat-timeout.name}"
    tags = ["${circonus_metric.raft-transition-heartbeat-timeout.tags}"]
    type = "${circonus_metric.raft-transition-heartbeat-timeout.type}"
  }

  metric {
    name = "${circonus_metric.raft-verify-leader.name}"
    tags = ["${circonus_metric.raft-verify-leader.tags}"]
    type = "${circonus_metric.raft-verify-leader.type}"
  }

  metric {
    name = "${circonus_metric.runtime-gc-pause.name}"
    tags = ["${circonus_metric.runtime-gc-pause.tags}"]
    type = "${circonus_metric.runtime-gc-pause.type}"
    unit = "${circonus_metric.runtime-gc-pause.unit}"
  }

  metric {
    name = "${circonus_metric.scada-connect-http.name}"
    tags = ["${circonus_metric.scada-connect-http.tags}"]
    type = "${circonus_metric.scada-connect-http.type}"
  }

  metric {
    name = "${circonus_metric.scada-disconnect.name}"
    tags = ["${circonus_metric.scada-disconnect.tags}"]
    type = "${circonus_metric.scada-disconnect.type}"
  }

  metric {
    name = "${circonus_metric.scada-flash.name}"
    tags = ["${circonus_metric.scada-flash.tags}"]
    type = "${circonus_metric.scada-flash.type}"
  }

  metric {
    name = "${circonus_metric.scada-handshake.name}"
    tags = ["${circonus_metric.scada-handshake.tags}"]
    type = "${circonus_metric.scada-handshake.type}"
  }

  metric {
    name = "${circonus_metric.scada-setup.name}"
    tags = ["${circonus_metric.scada-setup.tags}"]
    type = "${circonus_metric.scada-setup.type}"
  }

  metric {
    name = "${circonus_metric.serf-coordinate-adjustment.name}"
    tags = ["${circonus_metric.serf-coordinate-adjustment.tags}"]
    type = "${circonus_metric.serf-coordinate-adjustment.type}"
    unit = "${circonus_metric.serf-coordinate-adjustment.unit}"
  }

  metric {
    name = "${circonus_metric.serf-events.name}"
    tags = ["${circonus_metric.serf-events.tags}"]
    type = "${circonus_metric.serf-events.type}"
  }

  metric {
    name = "${circonus_metric.serf-events-consul-new-leader.name}"
    tags = ["${circonus_metric.serf-events-consul-new-leader.tags}"]
    type = "${circonus_metric.serf-events-consul-new-leader.type}"
  }

  metric {
    name = "${circonus_metric.serf-member-failed.name}"
    tags = ["${circonus_metric.serf-member-failed.tags}"]
    type = "${circonus_metric.serf-member-failed.type}"
  }

  metric {
    name = "${circonus_metric.serf-member-flap.name}"
    tags = ["${circonus_metric.serf-member-flap.tags}"]
    type = "${circonus_metric.serf-member-flap.type}"
  }

  metric {
    name = "${circonus_metric.serf-member-join.name}"
    tags = ["${circonus_metric.serf-member-join.tags}"]
    type = "${circonus_metric.serf-member-join.type}"
  }

  metric {
    name = "${circonus_metric.serf-member-left.name}"
    tags = ["${circonus_metric.serf-member-left.tags}"]
    type = "${circonus_metric.serf-member-left.type}"
  }

  metric {
    name = "${circonus_metric.serf-msgs-received.name}"
    tags = ["${circonus_metric.serf-msgs-received.tags}"]
    type = "${circonus_metric.serf-msgs-received.type}"
  }

  metric {
    name = "${circonus_metric.serf-msgs-sent.name}"
    tags = ["${circonus_metric.serf-msgs-sent.tags}"]
    type = "${circonus_metric.serf-msgs-sent.type}"
  }

  metric {
    name = "${circonus_metric.serf-queue-event.name}"
    tags = ["${circonus_metric.serf-queue-event.tags}"]
    type = "${circonus_metric.serf-queue-event.type}"
  }

  metric {
    name = "${circonus_metric.serf-queue-intent.name}"
    tags = ["${circonus_metric.serf-queue-intent.tags}"]
    type = "${circonus_metric.serf-queue-intent.type}"
  }

  metric {
    name = "${circonus_metric.serf-queue-query.name}"
    tags = ["${circonus_metric.serf-queue-query.tags}"]
    type = "${circonus_metric.serf-queue-query.type}"
  }

  metric {
    name = "${circonus_metric.serf-snapshot-append-line.name}"
    tags = ["${circonus_metric.serf-snapshot-append-line.tags}"]
    type = "${circonus_metric.serf-snapshot-append-line.type}"
  }

  metric {
    name = "${circonus_metric.serf-snapshot-compact.name}"
    tags = ["${circonus_metric.serf-snapshot-compact.tags}"]
    type = "${circonus_metric.serf-snapshot-compact.type}"
  }
}

resource "circonus_metric" "consul-session-ttl-active" {
  name = "consul`${var.hostname}`consul`session_ttl`active"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:session"]
  type = "numeric"
}

resource "circonus_metric" "memberlist-health-score" {
  name = "consul`${var.hostname}`memberlist`health`score"
  tags = ["${var.consul_tags}"]
  type = "numeric"
}

resource "circonus_metric" "runtime-alloc-bytes" {
  name = "consul`${var.hostname}`runtime`alloc_bytes"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "resource:memory"]
  type = "numeric"
  unit = "bytes"
}

resource "circonus_metric" "runtime-free-count" {
  name = "consul`${var.hostname}`runtime`free_count"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "resource:memory"]
  type = "numeric"
}

resource "circonus_metric" "runtime-heap-objects" {
  name = "consul`${var.hostname}`runtime`heap_objects"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "resource:memory"]
  type = "numeric"
}

resource "circonus_metric" "runtime-malloc-count" {
  name = "consul`${var.hostname}`runtime`malloc_count"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "resource:memory"]
  type = "numeric"
}

resource "circonus_metric" "runtime-num-goroutines" {
  name = "consul`${var.hostname}`runtime`num_goroutines"
  tags = ["${var.consul_tags}"]
  type = "numeric"
}

resource "circonus_metric" "runtime-sys-bytes" {
  name = "consul`${var.hostname}`runtime`sys_bytes"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "resource:memory"]
  type = "numeric"
  unit = "bytes"
}

resource "circonus_metric" "runtime-total-gc-pause" {
  name = "consul`${var.hostname}`runtime`total_gc_pause_ns"
  tags = ["${var.consul_tags}"]
  type = "numeric"
  unit = "nanoseconds"
}

resource "circonus_metric" "runtime-total-gc-runs" {
  name = "consul`${var.hostname}`runtime`total_gc_runs"
  tags = ["${var.consul_tags}"]
  type = "numeric"
}

resource "circonus_metric" "catalog-deregister" {
  name = "consul`consul`catalog`deregister"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:catalog"]
  type = "numeric"
}

resource "circonus_metric" "catalog-register" {
  name = "consul`consul`catalog`register"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:catalog"]
  type = "numeric"
}

resource "circonus_metric" "consul-fsm-coordinate-batch-update" {
  name = "consul`consul`fsm`coordinate`batch-update"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:fsm"]
  type = "histogram"
}

resource "circonus_metric" "consul-fsm-deregister" {
  name = "consul`consul`fsm`deregister"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:fsm"]
  type = "histogram"
}

resource "circonus_metric" "consul-fsm-kvs-delete" {
  name = "consul`consul`fsm`kvs`delete"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:fsm", "subsystem:kv", "operation:delete"]
  type = "histogram"
}

resource "circonus_metric" "consul-fsm-kvs-delete-cas" {
  name = "consul`consul`fsm`kvs`delete-cas"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:fsm", "subsystem:kv", "operation:delete", "operation:cas"]
  type = "histogram"
}

resource "circonus_metric" "consul-fsm-kvs-lock" {
  name = "consul`consul`fsm`kvs`lock"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:fsm", "subsystem:kv", "operation:lock"]
  type = "histogram"
}

resource "circonus_metric" "consul-fsm-kvs-set" {
  name = "consul`consul`fsm`kvs`set"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:fsm", "subsystem:kv", "operation:set"]
  type = "histogram"
}

resource "circonus_metric" "consul-fsm-kvs-unlock" {
  name = "consul`consul`fsm`kvs`unlock"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:fsm", "subsystem:kv", "operation:unlock"]
  type = "histogram"
}

resource "circonus_metric" "consul-fsm-persist" {
  name = "consul`consul`fsm`persist"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:fsm"]
  type = "histogram"
}

resource "circonus_metric" "consul-fsm-register" {
  name = "consul`consul`fsm`register"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:fsm"]
  type = "histogram"
}

resource "circonus_metric" "consul-fsm-session-create" {
  name = "consul`consul`fsm`session`create"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:fsm", "subsystem:session"]
  type = "histogram"
}

resource "circonus_metric" "consul-fsm-session-destroy" {
  name = "consul`consul`fsm`session`destroy"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:fsm", "subsystem:session"]
  type = "histogram"
}

resource "circonus_metric" "consul-fsm-tombstone-reap" {
  name = "consul`consul`fsm`tombstone`reap"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:fsm"]
  type = "histogram"
}

resource "circonus_metric" "consul-http-kv-delete" {
  name = "consul`consul`http`DELETE`v1`kv`_"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:kv", "operation:delete"]
  type = "histogram"
}

resource "circonus_metric" "consul-http-catalog-datacenters" {
  name = "consul`consul`http`GET`v1`catalog`datacenters"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:catalog", "operation:get", "interface:http"]
  type = "histogram"
}

resource "circonus_metric" "consul-http-catalog-node" {
  name = "consul`consul`http`GET`v1`catalog`node`_"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:catalog", "operation:get", "interface:http"]
  type = "histogram"
}

resource "circonus_metric" "consul-http-catalog-service" {
  name = "consul`consul`http`GET`v1`catalog`service`_"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:catalog", "operation:get", "interface:http"]
  type = "histogram"
}

resource "circonus_metric" "consul-http-coordinate-nodes" {
  name = "consul`consul`http`GET`v1`coordinate`nodes"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:catalog", "operation:get", "interface:http"]
  type = "histogram"
}

resource "circonus_metric" "consul-http-internal-ui-nodes" {
  name = "consul`consul`http`GET`v1`internal`ui`nodes"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:catalog", "operation:get", "interface:http"]
  type = "histogram"
}

resource "circonus_metric" "consul-http-internal-ui-service" {
  name = "consul`consul`http`GET`v1`internal`ui`services"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:catalog", "operation:get", "interface:http"]
  type = "histogram"
}

resource "circonus_metric" "consul-http-get-kv" {
  name = "consul`consul`http`GET`v1`kv`_"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:kv", "operation:get", "interface:http"]
  type = "histogram"
}

resource "circonus_metric" "consul-http-put-kv" {
  name = "consul`consul`http`PUT`v1`kv`_"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:kv", "operation:put", "interface:http"]
  type = "histogram"
}

resource "circonus_metric" "consul-kvs-apply" {
  name = "consul`consul`kvs`apply"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:kv"]
  type = "histogram"
}

resource "circonus_metric" "consul-leader-barrier" {
  name = "consul`consul`leader`barrier"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:raft"]
  type = "histogram"
}

resource "circonus_metric" "consul-leader-reap-tombstones" {
  name = "consul`consul`leader`reapTombstones"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:raft"]
  type = "histogram"
}

resource "circonus_metric" "consul-leader-reconcile" {
  name = "consul`consul`leader`reconcile"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:raft"]
  type = "histogram"
}

resource "circonus_metric" "consul-leader-reconcile-member" {
  name = "consul`consul`leader`reconcileMember"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:raft"]
  type = "histogram"
}

resource "circonus_metric" "consul-prepared-query-execute" {
  name = "consul`consul`prepared-query`execute"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:prepared-query"]
  type = "histogram"
}

resource "circonus_metric" "consul-rpc-accept-conn" {
  name = "consul`consul`rpc`accept_conn"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "interface:rpc"]
  type = "numeric"
}

resource "circonus_metric" "consul-rpc-consistent-read" {
  name = "consul`consul`rpc`consistentRead"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "interface:rpc"]
  type = "histogram"
}

resource "circonus_metric" "consul-rpc-query" {
  name = "consul`consul`rpc`query"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "interface:rpc"]
  type = "numeric"
}

resource "circonus_metric" "consul-rpc-raft-handoff" {
  name = "consul`consul`rpc`raft_handoff"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "interface:rpc", "subsystem:raft"]
  type = "numeric"
}

resource "circonus_metric" "consul-rpc-request" {
  name = "consul`consul`rpc`request"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "interface:rpc"]
  type = "numeric"
}

resource "circonus_metric" "consul-session-ttl-invalidate" {
  name = "consul`consul`session_ttl`invalidate"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:session"]
  type = "histogram"
}

resource "circonus_metric" "consul-session-apply" {
  name = "consul`consul`session`apply"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:session"]
  type = "histogram"
}

resource "circonus_metric" "consul-session-renew" {
  name = "consul`consul`session`renew"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:session"]
  type = "histogram"
}

resource "circonus_metric" "memberlist-degraded-probe" {
  name = "consul`memberlist`degraded`probe"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:memberlist"]
  type = "numeric"
}

resource "circonus_metric" "memberlist-gossip" {
  name = "consul`memberlist`gossip"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:memberlist"]
  type = "histogram"
}

resource "circonus_metric" "memberlist-msg-alive" {
  name = "consul`memberlist`msg`alive"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:memberlist"]
  type = "numeric"
}

resource "circonus_metric" "memberlist-msg-dead" {
  name = "consul`memberlist`msg`dead"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:memberlist"]
  type = "numeric"
}

resource "circonus_metric" "memberlist-msg-suspect" {
  name = "consul`memberlist`msg`suspect"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:memberlist"]
  type = "numeric"
}

resource "circonus_metric" "memberlist-probe-node" {
  name = "consul`memberlist`probeNode"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:memberlist"]
  type = "histogram"
}

resource "circonus_metric" "memberlist-push-pull-node" {
  name = "consul`memberlist`pushPullNode"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:memberlist"]
  type = "histogram"
}

resource "circonus_metric" "memberlist-tcp-accept" {
  name = "consul`memberlist`tcp`accept"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:memberlist"]
  type = "numeric"
}

resource "circonus_metric" "memberlist-tcp-connect" {
  name = "consul`memberlist`tcp`connect"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:memberlist"]
  type = "numeric"
}

resource "circonus_metric" "memberlist-tcp-sent" {
  name = "consul`memberlist`tcp`sent"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:memberlist"]
  type = "numeric"
}

resource "circonus_metric" "memberlist-udp-received" {
  name = "consul`memberlist`udp`received"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:memberlist"]
  type = "numeric"
}

resource "circonus_metric" "memberlist-udp-sent" {
  name = "consul`memberlist`udp`sent"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:memberlist"]
  type = "numeric"
}

resource "circonus_metric" "raft-apply" {
  name = "consul`raft`apply"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:raft"]
  type = "numeric"
}

resource "circonus_metric" "raft-barrier" {
  name = "consul`raft`barrier"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:raft"]
  type = "numeric"
}

resource "circonus_metric" "raft-candidate-elect-self" {
  name = "consul`raft`candidate`electSelf"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:raft"]
  type = "histogram"
}

resource "circonus_metric" "raft-commit-time" {
  name = "consul`raft`commitTime"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:raft"]
  type = "histogram"
}

resource "circonus_metric" "raft-compact-logs" {
  name = "consul`raft`compactLogs"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:raft"]
  type = "histogram"
}

resource "circonus_metric" "raft-fsm-apply" {
  name = "consul`raft`fsm`apply"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:fsm", "subsystem:raft"]
  type = "histogram"
}

resource "circonus_metric" "raft-fsm-restore" {
  name = "consul`raft`fsm`restore"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:fsm", "subsystem:raft"]
  type = "histogram"
}

resource "circonus_metric" "raft-fsm-snapshot" {
  name = "consul`raft`fsm`snapshot"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:fsm", "subsystem:raft"]
  type = "histogram"
}

resource "circonus_metric" "raft-leader-dispatch-log" {
  name = "consul`raft`leader`dispatchLog"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:raft"]
  type = "histogram"
}

resource "circonus_metric" "raft-leader-last-contact" {
  name = "consul`raft`leader`lastContact"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:raft"]
  type = "histogram"
}

resource "circonus_metric" "raft-rpc-append-entries" {
  name = "consul`raft`rpc`appendEntries"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:raft"]
  type = "histogram"
}

resource "circonus_metric" "raft-rpc-append-entries-process-logs" {
  name = "consul`raft`rpc`appendEntries`processLogs"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:raft"]
  type = "histogram"
}

resource "circonus_metric" "raft-rpc-append-entries-store-logs" {
  name = "consul`raft`rpc`appendEntries`storeLogs"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:raft"]
  type = "histogram"
}

resource "circonus_metric" "raft-rpc-install-snapshot" {
  name = "consul`raft`rpc`installSnapshot"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:raft"]
  type = "histogram"
}

resource "circonus_metric" "raft-rpc-process-heartbeat" {
  name = "consul`raft`rpc`processHeartbeat"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:raft", "interface:rpc"]
  type = "histogram"
}

resource "circonus_metric" "raft-rpc-request-vote" {
  name = "consul`raft`rpc`requestVote"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:raft", "interface:rpc"]
  type = "histogram"
}

resource "circonus_metric" "raft-snapshot-create" {
  name = "consul`raft`snapshot`create"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:raft"]
  type = "histogram"
}

resource "circonus_metric" "raft-snapshot-persist" {
  name = "consul`raft`snapshot`persist"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:raft"]
  type = "histogram"
}

resource "circonus_metric" "raft-snapshot-take-snapshot" {
  name = "consul`raft`snapshot`takeSnapshot"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:raft"]
  type = "histogram"
}

resource "circonus_metric" "raft-state-candidate" {
  name = "consul`raft`state`candidate"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:raft"]
  type = "numeric"
}

resource "circonus_metric" "raft-state-follower" {
  name = "consul`raft`state`follower"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:raft"]
  type = "numeric"
}

resource "circonus_metric" "raft-state-leader" {
  name = "consul`raft`state`leader"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:raft"]
  type = "numeric"
}

resource "circonus_metric" "raft-transition-heartbeat-timeout" {
  name = "consul`raft`transition`heartbeat_timeout"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:raft"]
  type = "numeric"
}

resource "circonus_metric" "raft-verify-leader" {
  name = "consul`raft`verify_leader"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:raft"]
  type = "numeric"
}

resource "circonus_metric" "runtime-gc-pause" {
  name = "consul`runtime`gc_pause_ns"
  tags = ["${var.consul_tags}"]
  type = "histogram"
  unit = "nanoseconds"
}

resource "circonus_metric" "scada-connect-http" {
  name = "consul`scada`connect`http"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:scada"]
  type = "numeric"
}

resource "circonus_metric" "scada-disconnect" {
  name = "consul`scada`disconnect"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:scada"]
  type = "numeric"
}

resource "circonus_metric" "scada-flash" {
  name = "consul`scada`flash"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:scada"]
  type = "numeric"
}

resource "circonus_metric" "scada-handshake" {
  name = "consul`scada`handshake"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:scada"]
  type = "histogram"
}

resource "circonus_metric" "scada-setup" {
  name = "consul`scada`setup"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:scada"]
  type = "histogram"
}

resource "circonus_metric" "serf-coordinate-adjustment" {
  name = "consul`serf`coordinate`adjustment-ms"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:serf"]
  type = "histogram"
  unit = "milliseconds"
}

resource "circonus_metric" "serf-events" {
  name = "consul`serf`events"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:serf"]
  type = "numeric"
}

resource "circonus_metric" "serf-events-consul-new-leader" {
  name = "consul`serf`events`consul:new-leader"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:raft", "subsystem:serf"]
  type = "numeric"
}

resource "circonus_metric" "serf-member-failed" {
  name = "consul`serf`member`failed"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:serf"]
  type = "numeric"
}

resource "circonus_metric" "serf-member-flap" {
  name = "consul`serf`member`flap"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:serf"]
  type = "numeric"
}

resource "circonus_metric" "serf-member-join" {
  name = "consul`serf`member`join"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:serf"]
  type = "numeric"
}

resource "circonus_metric" "serf-member-left" {
  name = "consul`serf`member`left"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:serf"]
  type = "numeric"
}

resource "circonus_metric" "serf-msgs-received" {
  name = "consul`serf`msgs`received"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:serf"]
  type = "histogram"
}

resource "circonus_metric" "serf-msgs-sent" {
  name = "consul`serf`msgs`sent"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:serf"]
  type = "histogram"
}

resource "circonus_metric" "serf-queue-event" {
  name = "consul`serf`queue`Event"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:serf"]
  type = "histogram"
}

resource "circonus_metric" "serf-queue-intent" {
  name = "consul`serf`queue`Intent"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:serf"]
  type = "histogram"
}

resource "circonus_metric" "serf-queue-query" {
  name = "consul`serf`queue`Query"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:serf"]
  type = "histogram"
}

resource "circonus_metric" "serf-snapshot-append-line" {
  name = "consul`serf`snapshot`appendLine"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:serf"]
  type = "histogram"
}

resource "circonus_metric" "serf-snapshot-compact" {
  name = "consul`serf`snapshot`compact"
  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:serf"]
  type = "histogram"
}

resource "circonus_metric_cluster" "catalog-service-queries" {
  name        = "${var.hostname} Consul Catalog Service Queries"
  description = "Aggregate catalog queries for Consul services on ${var.hostname}"

  query {
    definition = "(host:${var.hostname}) consul`consul`catalog`service`query`*"
    type       = "average"
  }

  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:catalog"]
}

resource "circonus_metric_cluster" "catalog-service-query-tags" {
  name        = "${var.hostname} Consul Catalog Service Query Tags"
  description = "Aggregate catalog queries for tags for Consul services on ${var.hostname}"

  query {
    definition = "(host:${var.hostname}) consul`consul`catalog`service`query-tag`*"
    type       = "average"
  }

  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:catalog"]
}

resource "circonus_metric_cluster" "raft-replication-append-entries-logs" {
  name        = "${var.hostname} Consul Raft Replication Append Entries Logs"
  description = "Number of append entries ${var.hostname} has sent out to its peers"

  query {
    definition = "(host:${var.hostname}) consul`raft`replication`appendEntries`logs`*"
    type       = "average"
  }

  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:raft"]
}

resource "circonus_metric_cluster" "raft-replication-append-entries-rpc" {
  name        = "${var.hostname} Consul Raft Replication Append Entry RPC Messages"
  description = "Number of append entry RPC messages ${var.hostname} has sent out to its peers"

  query {
    definition = "(host:${var.hostname}) consul`raft`replication`appendEntries`rpc`*"
    type       = "average"
  }

  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:raft", "interface:rpc"]
}

resource "circonus_metric_cluster" "raft-replication-heartbeats" {
  name        = "${var.hostname} Consul Raft Replication Heartbeat Messages"
  description = "Number of heartbeat messages ${var.hostname} has sent to its peers"

  query {
    definition = "(host:${var.hostname}) consul`raft`replication`heartbeat`*"
    type       = "average"
  }

  tags = ["${var.consul_tags}", "host:${var.hostname}", "subsystem:raft"]
}
