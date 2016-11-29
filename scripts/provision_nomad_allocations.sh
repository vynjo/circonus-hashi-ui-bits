#!/bin/bash

###### Nomad Client Metrics
## Numeric


go run create_cluster_and_graph_and_caql.go -query "nomad*client*allocs*allocation_name*cpu*system" -title "Nomad client allocs allocation_name cpu system" -tags "creator:api,role:allocation,service:nomad,data-type:numeric,group:primary"
go run create_cluster_and_graph_and_caql.go -query "nomad*client*allocs*allocation_name*cpu*throttled_periods" -title "Nomad client allocs allocation_name cpu throttled_periods" -tags "creator:api,role:allocation,service:nomad,data-type:numeric,group:primary"
go run create_cluster_and_graph_and_caql.go -query "nomad*client*allocs*allocation_name*cpu*throttled_time" -title "Nomad client allocs allocation_name cpu throttled_time" -tags "creator:api,role:allocation,service:nomad,data-type:numeric,group:primary"
go run create_cluster_and_graph_and_caql.go -query "nomad*client*allocs*allocation_name*cpu*total_percent" -title "Nomad client allocs allocation_name cpu total_percent" -tags "creator:api,role:allocation,service:nomad,data-type:numeric,group:primary"
go run create_cluster_and_graph_and_caql.go -query "nomad*client*allocs*allocation_name*cpu*total_ticks" -title "Nomad client allocs allocation_name cpu total_ticks" -tags "creator:api,role:allocation,service:nomad,data-type:numeric,group:primary"
go run create_cluster_and_graph_and_caql.go -query "nomad*client*allocs*allocation_name*cpu*user" -title "Nomad client allocs allocation_name cpu user" -tags "creator:api,role:allocation,service:nomad,data-type:numeric,group:primary"
go run create_cluster_and_graph_and_caql.go -query "nomad*client*allocs*allocation_name*memory*cache" -title "Nomad client allocs allocation_name memory cache" -tags "creator:api,role:allocation,service:nomad,data-type:numeric,group:primary"
go run create_cluster_and_graph_and_caql.go -query "nomad*client*allocs*allocation_name*memory*kernel_max_usage" -title "Nomad client allocs allocation_name memory kernel_max_usage" -tags "creator:api,role:allocation,service:nomad,data-type:numeric,group:primary"
go run create_cluster_and_graph_and_caql.go -query "nomad*client*allocs*allocation_name*memory*kernel_usage" -title "Nomad client allocs allocation_name memory kernel_usage" -tags "creator:api,role:allocation,service:nomad,data-type:numeric,group:primary"
go run create_cluster_and_graph_and_caql.go -query "nomad*client*allocs*allocation_name*memory*max_usage" -title "Nomad client allocs allocation_name memory max_usage" -tags "creator:api,role:allocation,service:nomad,data-type:numeric,group:primary"
go run create_cluster_and_graph_and_caql.go -query "nomad*client*allocs*allocation_name*memory*rss" -title "Nomad client allocs allocation_name memory rss" -tags "creator:api,role:allocation,service:nomad,data-type:numeric,group:primary"
go run create_cluster_and_graph_and_caql.go -query "nomad*client*allocs*allocation_name*memory*swap" -title "Nomad client allocs allocation_name memory swap" -tags "creator:api,role:allocation,service:nomad,data-type:numeric,group:primary"
