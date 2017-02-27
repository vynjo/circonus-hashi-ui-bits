#!/bin/bash

###### Consul Server Metrics
## Numeric

create_cgc -query "*consul*consul*catalog*service*not-found*nomad*" -title "Consul catalog service not-found nomad" -tags "creator:api,role:server,service:consul,data-type:counter,group:secondary"
create_cgc -query "*consul*consul*catalog*service*not-found*vault*" -title "Consul catalog service not-found vault" -tags "creator:api,role:server,service:consul,data-type:counter,group:secondary"
create_cgc -query "*consul*consul*catalog*service*query-tag*nomad*rpc*" -title "Consul catalog service query-tag nomad rpc" -tags "creator:api,role:server,service:consul,data-type:counter,group:secondary"
create_cgc -query "*consul*consul*catalog*service*query-tag*nomad*serf*" -title "Consul catalog service query-tag nomad serf" -tags "creator:api,role:server,service:consul,data-type:counter,group:secondary"
create_cgc -query "*consul*consul*catalog*service*query*nomad*" -title "Consul catalog service query nomad" -tags "creator:api,role:server,service:consul,data-type:counter,group:secondary"
create_cgc -query "*consul*consul*catalog*service*query*vault*" -title "Consul catalog service query vault" -tags "creator:api,role:server,service:consul,data-type:counter,group:secondary"
create_cgc -query "*consul*consul*health*service*query*vault*" -title "Consul health service query vault" -tags "creator:api,role:server,service:consul,data-type:counter,group:secondary"
create_cgc -query "*consul*consul*rpc*accept_conn*" -title "Consul rpc accept_conn" -tags "creator:api,role:server,service:consul,data-type:counter,group:secondary"
create_cgc -query "*consul*consul*rpc*query*" -title "Consul rpc query" -tags "creator:api,role:server,service:consul,data-type:counter,group:secondary"
create_cgc -query "*consul*consul*rpc*raft_handoff*" -title "Consul rpc raft_handoff" -tags "creator:api,role:server,service:consul,data-type:counter,group:secondary"
create_cgc -query "*consul*consul*rpc*request*" -title "Consul rpc request" -tags "creator:api,role:server,service:consul,data-type:counter,group:secondary"

create_cgc -query "*consul*memberlist*degraded*probe*" -title "Consul memberlist degraded probe" -tags "creator:api,role:server,service:consul,data-type:counter,group:secondary"
create_cgc -query "*consul*memberlist*msg*alive*" -title "Consul memberlist msg alive" -tags "creator:api,role:server,service:consul,data-type:counter,group:secondary"
create_cgc -query "*consul*memberlist*msg*dead*" -title "Consul memberlist msg dead" -tags "creator:api,role:server,service:consul,data-type:counter,group:secondary"
create_cgc -query "*consul*memberlist*msg*suspect*" -title "Consul memberlist msg suspect" -tags "creator:api,role:server,service:consul,data-type:counter,group:secondary"
create_cgc -query "*consul*memberlist*tcp*accept*" -title "Consul memberlist tcp accept" -tags "creator:api,role:server,service:consul,data-type:counter,group:secondary"
create_cgc -query "*consul*memberlist*tcp*connect*" -title "Consul memberlist tcp connect" -tags "creator:api,role:server,service:consul,data-type:counter,group:secondary"
create_cgc -query "*consul*memberlist*tcp*sent*" -title "Consul memberlist tcp sent" -tags "creator:api,role:server,service:consul,data-type:counter,group:secondary"
create_cgc -query "*consul*memberlist*udp*received*" -title "Consul memberlist udp received" -tags "creator:api,role:server,service:consul,data-type:counter,group:secondary"
create_cgc -query "*consul*memberlist*udp*sent*" -title "Consul memberlist udp sent" -tags "creator:api,role:server,service:consul,data-type:counter,group:secondary"

create_cgc -query "*consul*consul*session_ttl*active*" -title "Consul * Consul session_ttl active" -tags "creator:api,role:server,service:consul,data-type:counter,group:secondary"

create_cgc -query "*consul*memberlist*health*score*" -title "Consul * memberlist health score" -tags "creator:api,role:server,service:consul,data-type:counter,group:secondary"

create_cgc -query "*consul*runtime*alloc_bytes*" -title "Consul * runtime alloc_bytes" -tags "creator:api,role:server,service:consul,data-type:counter,group:secondary"
create_cgc -query "*consul*runtime*free_count*" -title "Consul * runtime free_count" -tags "creator:api,role:server,service:consul,data-type:counter,group:secondary"
create_cgc -query "*consul*runtime*heap_objects*" -title "Consul * runtime heap_objects" -tags "creator:api,role:server,service:consul,data-type:counter,group:secondary"
create_cgc -query "*consul*runtime*malloc_count*" -title "Consul * runtime malloc_count" -tags "creator:api,role:server,service:consul,data-type:counter,group:secondary"
create_cgc -query "*consul*runtime*num_goroutines*" -title "Consul * runtime num_goroutines" -tags "creator:api,role:server,service:consul,data-type:counter,group:secondary"
create_cgc -query "*consul*runtime*sys_bytes*" -title "Consul * runtime sys_bytes" -tags "creator:api,role:server,service:consul,data-type:counter,group:secondary"
create_cgc -query "*consul*runtime*total_gc_pause_ns*" -title "Consul * runtime total_gc_pause_ns" -tags "creator:api,role:server,service:consul,data-type:counter,group:secondary"
create_cgc -query "*consul*runtime*total_gc_runs*" -title "Consul * runtime total_gc_runs" -tags "creator:api,role:server,service:consul,data-type:counter,group:secondary"

create_cgc -query "*consul*raft*state*candidate*" -title "Consul raft state candidate" -tags "creator:api,role:server,service:consul,data-type:counter,group:secondary"
create_cgc -query "*consul*raft*state*follower*" -title "Consul raft state follower" -tags "creator:api,role:server,service:consul,data-type:counter,group:secondary"
create_cgc -query "*consul*raft*transition*heartbeat_timeout*" -title "Consul raft transition heartbeat_timeout" -tags "creator:api,role:server,service:consul,data-type:counter,group:secondary"

create_cgc -query "*consul*serf*events*" -title "Consul serf events" -tags "creator:api,role:server,service:consul,data-type:counter,group:secondary"
create_cgc -query "*consul*serf*events*consul:new-leader*" -title "Consul serf events consul:new-leader" -tags "creator:api,role:server,service:consul,data-type:counter,group:secondary"
create_cgc -query "*consul*serf*member*failed*" -title "Consul serf member failed" -tags "creator:api,role:server,service:consul,data-type:counter,group:secondary"
create_cgc -query "*consul*serf*member*flap*" -title "Consul serf member flap" -tags "creator:api,role:server,service:consul,data-type:counter,group:primary"
create_cgc -query "*consul*serf*member*join*" -title "Consul serf member join" -tags "creator:api,role:server,service:consul,data-type:counter,group:secondary"
create_cgc -query "*consul*serf*member*left*" -title "Consul serf member left" -tags "creator:api,role:server,service:consul,data-type:counter,group:secondary"
create_cgc -query "*consul*serf*member*update*" -title "Consul serf member update" -tags "creator:api,role:server,service:consul,data-type:counter,group:secondary"

###### Consul Client Metrics
##N Histogram

create_cgc -query "*consul*consul*fsm*coordinate*batch-update*"	-title "Consul fsm coordinate batch-update"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:secondary"
create_cgc -query "*consul*consul*fsm*deregister*"	-title "Consul fsm deregister"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:secondary"
create_cgc -query "*consul*consul*fsm*kvs*delete*"	-title "Consul fsm kvs delete"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:secondary"
create_cgc -query "*consul*consul*fsm*kvs*lock*"	-title "Consul fsm kvs lock"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:secondary"
create_cgc -query "*consul*consul*fsm*kvs*set*"	-title "Consul fsm kvs set"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:secondary"
create_cgc -query "*consul*consul*fsm*persist*"	-title "Consul fsm persist"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:secondary"
create_cgc -query "*consul*consul*fsm*register*"	-title "Consul fsm register"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:secondary"
create_cgc -query "*consul*consul*fsm*session*create*"	-title "Consul fsm session create"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:secondary"
create_cgc -query "*consul*consul*fsm*session*destroy*"	-title "Consul fsm session destroy"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:secondary"
create_cgc -query "*consul*consul*fsm*tombstone*reap*"	-title "Consul fsm tombstone reap"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:secondary"

create_cgc -query "*consul*consul*http*DELETE*v1*kv*_*"	-title "Consul http DELETE v1 kv _"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:primary"
create_cgc -query "*consul*consul*http*GET*v1*acl*list*"	-title "Consul http GET v1 acl list"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:primary"
create_cgc -query "*consul*consul*http*GET*v1*agent*checks*"	-title "Consul http GET v1 agent checks"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:primary"
create_cgc -query "*consul*consul*http*GET*v1*agent*self*"	-title "Consul http GET v1 agent self"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:primary"
create_cgc -query "*consul*consul*http*GET*v1*agent*services*"	-title "Consul http GET v1 agent services"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:primary"
create_cgc -query "*consul*consul*http*GET*v1*catalog*datacenters*"	-title "Consul http GET v1 catalog datacenters"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:primary"
create_cgc -query "*consul*consul*http*GET*v1*catalog*service*_*"	-title "Consul http GET v1 catalog service _"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:primary"
create_cgc -query "*consul*consul*http*GET*v1*coordinate*nodes*"	-title "Consul http GET v1 coordinate nodes"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:primary"
create_cgc -query "*consul*consul*http*GET*v1*health*service*_*"	-title "Consul http GET v1 health service _"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:primary"
create_cgc -query "*consul*consul*http*GET*v1*health*state*_*"	-title "Consul http GET v1 health state _"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:primary"
create_cgc -query "*consul*consul*http*GET*v1*internal*ui*nodes*"	-title "Consul http GET v1 internal ui nodes"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:primary"
create_cgc -query "*consul*consul*http*GET*v1*internal*ui*node*_*"	-title "Consul http GET v1 internal ui node _"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:primary"
create_cgc -query "*consul*consul*http*GET*v1*internal*ui*services*"	-title "Consul http GET v1 internal ui services"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:primary"
create_cgc -query "*consul*consul*http*GET*v1*kv*_*"	-title "Consul http GET v1 kv _"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:primary"
create_cgc -query "*consul*consul*http*GET*v1*session*node*_*"	-title "Consul http GET v1 session node _"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:secondary"
create_cgc -query "*consul*consul*http*PUT*v1*agent*check*deregister*_*"	-title "Consul http PUT v1 agent check deregister _"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:secondary"
create_cgc -query "*consul*consul*http*PUT*v1*agent*check*fail*_*"	-title "Consul http PUT v1 agent check fail _"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:secondary"
create_cgc -query "*consul*consul*http*PUT*v1*agent*check*pass*_*"	-title "Consul http PUT v1 agent check pass _"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:secondary"
create_cgc -query "*consul*consul*http*PUT*v1*agent*check*register*"	-title "Consul http PUT v1 agent check register"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:secondary"
create_cgc -query "*consul*consul*http*PUT*v1*agent*service*deregister*_*"	-title "Consul http PUT v1 agent service deregister _"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:secondary"
create_cgc -query "*consul*consul*http*PUT*v1*agent*service*register*"	-title "Consul http PUT v1 agent service register"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:secondary"
create_cgc -query "*consul*consul*http*PUT*v1*kv*_*"	-title "Consul http PUT v1 kv _"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:primary"
create_cgc -query "*consul*consul*http*PUT*v1*session*create*"	-title "Consul http PUT v1 session create"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:primary"
create_cgc -query "*consul*consul*http*PUT*v1*session*renew*_*"	-title "Consul http PUT v1 session renew _"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:primary"

create_cgc -query "*consul*memberlist*gossip*"	-title "Consul memberlist gossip"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:secondary"
create_cgc -query "*consul*memberlist*probeNode*"	-title "Consul memberlist probeNode"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:secondary"
create_cgc -query "*consul*memberlist*pushPullNode*"	-title "Consul memberlist pushPullNode"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:secondary"

create_cgc -query "*consul*raft*candidate*electSelf*"	-title "Consul raft candidate electSelf"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:secondary"
create_cgc -query "*consul*raft*compactLogs*"	-title "Consul raft compactLogs"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:secondary"
create_cgc -query "*consul*raft*fsm*apply*"	-title "Consul raft fsm apply"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:primary"
create_cgc -query "*consul*raft*fsm*snapshot*"	-title "Consul raft fsm snapshot"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:secondary"
create_cgc -query "*consul*raft*rpc*appendEntries*"	-title "Consul raft rpc appendEntries"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:secondary"
create_cgc -query "*consul*raft*rpc*appendEntries*processLogs*"	-title "Consul raft rpc appendEntries processLogs"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:secondary"
create_cgc -query "*consul*raft*rpc*appendEntries*storeLogs*"	-title "Consul raft rpc appendEntries storeLogs"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:secondary"
create_cgc -query "*consul*raft*rpc*processHeartbeat*"	-title "Consul raft rpc processHeartbeat"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:secondary"
create_cgc -query "*consul*raft*rpc*requestVote*"	-title "Consul raft rpc requestVote"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:secondary"
create_cgc -query "*consul*raft*snapshot*create*"	-title "Consul raft snapshot create"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:secondary"
create_cgc -query "*consul*raft*snapshot*persist*"	-title "Consul raft snapshot persist"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:secondary"
create_cgc -query "*consul*raft*snapshot*takeSnapshot*"	-title "Consul raft snapshot takeSnapshot"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:secondary"

create_cgc -query "*consul*runtime*gc_pause_ns*"	-title "Consul runtime gc_pause_ns"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:secondary"

create_cgc -query "*consul*serf*coordinate*adjustment-ms*"	-title "Consul serf coordinate adjustment-ms"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:secondary"
create_cgc -query "*consul*serf*msgs*received*"	-title "Consul serf msgs received"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:secondary"
create_cgc -query "*consul*serf*msgs*sent*"	-title "Consul serf msgs sent"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:secondary"
create_cgc -query "*consul*serf*queue*Event*"	-title "Consul serf queue Event"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:secondary"
create_cgc -query "*consul*serf*queue*Intent*"	-title "Consul serf queue Intent"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:secondary"
create_cgc -query "*consul*serf*queue*Query*"	-title "Consul serf queue Query"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:secondary"
create_cgc -query "*consul*serf*snapshot*appendLine*"	-title "Consul serf snapshot appendLine"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:secondary"
create_cgc -query "*consul*serf*snapshot*compact*"	-title "Consul serf snapshot compact"	-tags "creator:api,role:server,service:consul,data-type:histogram,group:secondary"
