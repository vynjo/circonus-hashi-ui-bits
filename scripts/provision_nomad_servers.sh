
###### Consul Server Metrics
## Numeric
./create_cgc -query "nomad*memberlist*degraded*probe" -title "Nomad memberlist degraded probe" -tags "creator:api,role:server,service:nomad,data-type:counter,group:secondary";
./create_cgc -query "nomad*memberlist*msg*alive" -title "Nomad memberlist msg alive" -tags "creator:api,role:server,service:nomad,data-type:counter,group:secondary";
./create_cgc -query "nomad*memberlist*msg*dead" -title "Nomad memberlist msg dead" -tags "creator:api,role:server,service:nomad,data-type:counter,group:secondary";
./create_cgc -query "nomad*memberlist*msg*suspect" -title "Nomad memberlist msg suspect" -tags "creator:api,role:server,service:nomad,data-type:counter,group:secondary";
./create_cgc -query "nomad*memberlist*tcp*accept" -title "Nomad memberlist tcp accept" -tags "creator:api,role:server,service:nomad,data-type:counter,group:secondary";
./create_cgc -query "nomad*memberlist*tcp*connect" -title "Nomad memberlist tcp connect" -tags "creator:api,role:server,service:nomad,data-type:counter,group:secondary";
./create_cgc -query "nomad*memberlist*tcp*sent" -title "Nomad memberlist tcp sent" -tags "creator:api,role:server,service:nomad,data-type:counter,group:secondary";
./create_cgc -query "nomad*memberlist*udp*received" -title "Nomad memberlist udp received" -tags "creator:api,role:server,service:nomad,data-type:counter,group:secondary";
./create_cgc -query "nomad*memberlist*udp*sent" -title "Nomad memberlist udp sent" -tags "creator:api,role:server,service:nomad,data-type:counter,group:secondary";
./create_cgc -query "nomad*nomad*rpc*accept_conn" -title "Nomad rpc accept_conn" -tags "creator:api,role:server,service:nomad,data-type:counter,group:secondary";
./create_cgc -query "nomad*nomad*rpc*query" -title "Nomad rpc query" -tags "creator:api,role:server,service:nomad,data-type:counter,group:primary";
./create_cgc -query "nomad*nomad*rpc*raft_handoff" -title "Nomad rpc raft_handoff" -tags "creator:api,role:server,service:nomad,data-type:counter,group:secondary";
./create_cgc -query "nomad*nomad*rpc*request" -title "Nomad rpc request" -tags "creator:api,role:server,service:nomad,data-type:counter,group:primary";

./create_cgc -query "nomad*memberlist*health*score" -title "Nomad * memberlist health score" -tags "creator:api,role:server,service:nomad,data-type:counter,group:secondary";
./create_cgc -query "nomad*nomad*blocked_evals*total_blocked" -title "Nomad nomad blocked_evals total_blocked" -tags "creator:api,role:server,service:nomad,data-type:counter,group:secondary";
./create_cgc -query "nomad*nomad*blocked_evals*total_escaped" -title "Nomad nomad blocked_evals total_escaped" -tags "creator:api,role:server,service:nomad,data-type:counter,group:secondary";
./create_cgc -query "nomad*nomad*broker*service*ready" -title "Nomad nomad broker service ready" -tags "creator:api,role:server,service:nomad,data-type:counter,group:secondary";
./create_cgc -query "nomad*nomad*broker*service*unacked" -title "Nomad nomad broker service unacked" -tags "creator:api,role:server,service:nomad,data-type:counter,group:secondary";
./create_cgc -query "nomad*nomad*broker*system*ready" -title "Nomad nomad broker system ready" -tags "creator:api,role:server,service:nomad,data-type:counter,group:secondary";
./create_cgc -query "nomad*nomad*broker*system*unacked" -title "Nomad nomad broker system unacked" -tags "creator:api,role:server,service:nomad,data-type:counter,group:secondary";

./create_cgc -query "nomad*nomad*broker*total_blocked" -title "Nomad nomad broker total_blocked" -tags "creator:api,role:server,service:nomad,data-type:counter,group:secondary";
./create_cgc -query "nomad*nomad*broker*total_ready" -title "Nomad nomad broker total_ready" -tags "creator:api,role:server,service:nomad,data-type:counter,group:secondary";
./create_cgc -query "nomad*nomad*broker*total_unacked" -title "Nomad nomad broker total_unacked" -tags "creator:api,role:server,service:nomad,data-type:counter,group:secondary";
./create_cgc -query "nomad*nomad*broker*total_waiting" -title "Nomad nomad broker total_waiting" -tags "creator:api,role:server,service:nomad,data-type:counter,group:secondary";
./create_cgc -query "nomad*nomad*broker*_core*ready" -title "Nomad nomad broker _core ready" -tags "creator:api,role:server,service:nomad,data-type:counter,group:secondary";
./create_cgc -query "nomad*nomad*broker*_core*unacked" -title "Nomad nomad broker _core unacked" -tags "creator:api,role:server,service:nomad,data-type:counter,group:secondary";

./create_cgc -query "nomad*nomad*heartbeat*active" -title "Nomad nomad heartbeat active" -tags "creator:api,role:server,service:nomad,data-type:counter,group:secondary";
./create_cgc -query "nomad*nomad*plan*queue_depth" -title "Nomad nomad plan queue_depth" -tags "creator:api,role:server,service:nomad,data-type:counter,group:secondary";

./create_cgc -query "nomad*runtime*alloc_bytes" -title "Nomad runtime alloc_bytes" -tags "creator:api,role:server,service:nomad,data-type:counter,group:secondary";
./create_cgc -query "nomad*runtime*free_count" -title "Nomad runtime free_count" -tags "creator:api,role:server,service:nomad,data-type:counter,group:secondary";
./create_cgc -query "nomad*runtime*heap_objects" -title "Nomad runtime heap_objects" -tags "creator:api,role:server,service:nomad,data-type:gauge,group:secondary";
./create_cgc -query "nomad*runtime*malloc_count" -title "Nomad runtime malloc_count" -tags "creator:api,role:server,service:nomad,data-type:counter,group:secondary";
./create_cgc -query "nomad*runtime*num_goroutines" -title "Nomad runtime num_goroutines" -tags "creator:api,role:server,service:nomad,data-type:counter,group:secondary";
./create_cgc -query "nomad*runtime*sys_bytes" -title "Nomad runtime sys_bytes" -tags "creator:api,role:server,service:nomad,data-type:gauge,group:secondary";
./create_cgc -query "nomad*runtime*total_gc_pause_ns" -title "Nomad runtime total_gc_pause_ns" -tags "creator:api,role:server,service:nomad,data-type:counter,group:secondary";
./create_cgc -query "nomad*runtime*total_gc_runs" -title "Nomad runtime total_gc_runs" -tags "creator:api,role:server,service:nomad,data-type:gauge,group:secondary"
./create_cgc -query "nomad*raft*apply" -title "Nomad raft apply" -tags "creator:api,role:server,service:nomad,data-type:counter,group:secondary"
./create_cgc -query "nomad*raft*barrier" -title "Nomad raft barrier" -tags "creator:api,role:server,service:nomad,data-type:counter,group:secondary"
./create_cgc -query "nomad*raft*replication*appendEntries*logs" -title "Nomad raft replication appendEntries logs" -tags "creator:api,role:server,service:nomad,data-type:counter,group:secondary"
./create_cgc -query "nomad*raft*state*candidate" -title "Nomad raft state candidate" -tags "creator:api,role:server,service:nomad,data-type:counter,group:secondary"
./create_cgc -query "nomad*raft*state*follower" -title "Nomad raft state follower" -tags "creator:api,role:server,service:nomad,data-type:counter,group:secondary"
./create_cgc -query "nomad*raft*state*leader" -title "Nomad raft state leader" -tags "creator:api,role:server,service:nomad,data-type:counter,group:secondary"
./create_cgc -query "nomad*raft*transition*heartbeat_timeout" -title "Nomad raft transition heartbeat_timeout" -tags "creator:api,role:server,service:nomad,data-type:counter,group:secondary"
./create_cgc -query "nomad*raft*transition*leader_lease_timeout" -title "Nomad raft transition leader_lease_timeout" -tags "creator:api,role:server,service:nomad,data-type:counter,group:secondary"
./create_cgc -query "nomad*serf*member*failed" -title "Nomad serf member failed" -tags "creator:api,role:server,service:nomad,data-type:counter,group:secondary"
./create_cgc -query "nomad*serf*member*flap" -title "Nomad serf member flap" -tags "creator:api,role:server,service:nomad,data-type:counter,group:secondary"
./create_cgc -query "nomad*serf*member*join" -title "Nomad serf member join" -tags "creator:api,role:server,service:nomad,data-type:counter,group:secondary"
./create_cgc -query "nomad*serf*member*update" -title "Nomad serf member update" -tags "creator:api,role:server,service:nomad,data-type:counter,group:secondary"

###### Consul Server Metrics
## Histogram

# -query "nomad*memberlist*gossip"	-title "Nomad memberlist gossip"	-tags  "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*memberlist*probeNode"	-title "Nomad memberlist probeNode"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*memberlist*pushPullNode"	-title "Nomad memberlist pushPullNode"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*nomad*alloc*get_alloc"	-title "Nomad alloc get_alloc"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*nomad*alloc*list"	-title "Nomad alloc list"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*nomad*client*get_client_allocs"	-title "Nomad client get_client_allocs"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*nomad*client*get_node"	-title "Nomad client get_node"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*nomad*client*list"	-title "Nomad client list"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*nomad*client*register"	-title "Nomad client register"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*nomad*client*update_alloc"	-title "Nomad client update_alloc"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*nomad*client*update_status"	-title "Nomad client update_status"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*nomad*eval*ack"	-title "Nomad eval ack"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*nomad*eval*allocations"	-title "Nomad eval allocations"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*nomad*eval*create"	-title "Nomad eval create"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*nomad*eval*dequeue"	-title "Nomad eval dequeue"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*nomad*eval*get_eval"	-title "Nomad eval get_eval"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*nomad*eval*reap"	-title "Nomad eval reap"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*nomad*eval*update"	-title "Nomad eval update"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*nomad*fsm*alloc_client_update"	-title "Nomad fsm alloc_client_update"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*nomad*fsm*alloc_update"	-title "Nomad fsm alloc_update"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*nomad*fsm*delete_eval"	-title "Nomad fsm delete_eval"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*nomad*fsm*deregister_job"	-title "Nomad fsm deregister_job"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*nomad*fsm*deregister_node"	-title "Nomad fsm deregister_node"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*nomad*fsm*node_status_update"	-title "Nomad fsm node_status_update"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*nomad*fsm*persist"	-title "Nomad fsm persist"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*nomad*fsm*register_job"	-title "Nomad fsm register_job"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*nomad*fsm*register_node"	-title "Nomad fsm register_node"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*nomad*fsm*update_eval"	-title "Nomad fsm update_eval"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*nomad*heartbeat*invalidate"	-title "Nomad heartbeat invalidate"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*nomad*job_summary*get_job_summary"	-title "Nomad job_summary get_job_summary"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*nomad*job*allocations"	-title "Nomad job allocations"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:primary"
# -query "nomad*nomad*job*deregister"	-title "Nomad job deregister"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:primary"
# -query "nomad*nomad*job*evaluations"	-title "Nomad job evaluations"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:primary"
# -query "nomad*nomad*job*get_job"	-title "Nomad job get_job"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*nomad*job*list"	-title "Nomad job list"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*nomad*job*register"	-title "Nomad job register"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:primary"
# -query "nomad*nomad*leader*barrier"	-title "Nomad leader barrier"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*nomad*leader*reconcile"	-title "Nomad leader reconcile"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*nomad*leader*reconcileMember"	-title "Nomad leader reconcileMember"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*nomad*plan*apply"	-title "Nomad plan apply"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:primary"
# -query "nomad*nomad*plan*evaluate"	-title "Nomad plan evaluate"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:primary"
# -query "nomad*nomad*plan*submit"	-title "Nomad plan submit"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:primary"
# -query "nomad*nomad*worker*create_eval"	-title "Nomad worker create_eval"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*nomad*worker*dequeue_eval"	-title "Nomad worker dequeue_eval"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*nomad*worker*invoke_scheduler*service"	-title "Nomad worker invoke_scheduler service"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*nomad*worker*invoke_scheduler*system"	-title "Nomad worker invoke_scheduler system"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*nomad*worker*invoke_scheduler*_core"	-title "Nomad worker invoke_scheduler _core"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*nomad*worker*reblock_eval"	-title "Nomad worker reblock_eval"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*nomad*worker*send_ack"	-title "Nomad worker send_ack"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*nomad*worker*submit_plan"	-title "Nomad worker submit_plan"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*nomad*worker*update_eval"	-title "Nomad worker update_eval"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*nomad*worker*wait_for_index"	-title "Nomad worker wait_for_index"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*raft*candidate*electSelf"	-title "Nomad raft candidate electSelf"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*raft*commitTime"	-title "Nomad raft commitTime"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*raft*compactLogs"	-title "Nomad raft compactLogs"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*raft*fsm*apply"	-title "Nomad raft fsm apply"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*raft*fsm*snapshot"	-title "Nomad raft fsm snapshot"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*raft*leader*dispatchLog"	-title "Nomad raft leader dispatchLog"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*raft*leader*lastContact"	-title "Nomad raft leader lastContact"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*raft*replication*appendEntries*rpc"	-title "Nomad raft replication appendEntries rpc"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*raft*replication*heartbeat"	-title "Nomad raft replication heartbeat"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*raft*rpc*appendEntries"	-title "Nomad raft rpc appendEntries"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*raft*rpc*appendEntries*processLogs"	-title "Nomad raft rpc appendEntries processLogs"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*raft*rpc*appendEntries*storeLogs"	-title "Nomad raft rpc appendEntries storeLogs"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*raft*rpc*processHeartbeat"	-title "Nomad raft rpc processHeartbeat"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*raft*rpc*requestVote"	-title "Nomad raft rpc requestVote"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*raft*snapshot*create"	-title "Nomad raft snapshot create"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*raft*snapshot*persist"	-title "Nomad raft snapshot persist"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*raft*snapshot*takeSnapshot"	-title "Nomad raft snapshot takeSnapshot"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*runtime*gc_pause_ns"	-title "Nomad runtime gc_pause_ns"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*serf*coordinate*adjustment-ms"	-title "Nomad serf coordinate adjustment-ms"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*serf*msgs*received"	-title "Nomad serf msgs received"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*serf*msgs*sent"	-title "Nomad serf msgs sent"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*serf*queue*Event"	-title "Nomad serf queue Event"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*serf*queue*Intent"	-title "Nomad serf queue Intent"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*serf*queue*Query"	-title "Nomad serf queue Query"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*serf*snapshot*appendLine"	-title "Nomad serf snapshot appendLine"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"
# -query "nomad*serf*snapshot*compact"	-title "Nomad serf snapshot compact"	-tags "creator:api,role:server,service:nomad,data-type:histogram,group:secondary"