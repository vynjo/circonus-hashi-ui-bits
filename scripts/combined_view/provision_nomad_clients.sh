#!/bin/bash

###### Nomad Client Metrics
##gauge


../../cmd/create_cgc/create_cgc -query "nomad*client*host*cpu*idle" -title "Nomad client host cpu idle" -tags "creator:api,role:client,service:nomad,data-type:gauge,group:primary"
../../cmd/create_cgc/create_cgc -query "nomad*client*host*cpu*system" -title "Nomad client host cpu system" -tags "creator:api,role:client,service:nomad,data-type:gauge,group:primary"
../../cmd/create_cgc/create_cgc -query "nomad*client*host*cpu*total" -title "Nomad client host cpu total" -tags "creator:api,role:client,service:nomad,data-type:gauge,group:primary"
../../cmd/create_cgc/create_cgc -query "nomad*client*host*cpu*user" -title "Nomad client host cpu user" -tags "creator:api,role:client,service:nomad,data-type:gauge,group:primary"

../../cmd/create_cgc/create_cgc -query "nomad*client*host*disk*available" -title "Nomad client host disk /dev/sda1 available" -tags "creator:api,role:client,service:nomad,data-type:gauge,group:primary"
../../cmd/create_cgc/create_cgc -query "nomad*client*host*disk*inodes_percent" -title "Nomad client host disk /dev/sda1 inodes_percent" -tags "creator:api,role:client,service:nomad,data-type:gauge,group:primary"
../../cmd/create_cgc/create_cgc -query "nomad*client*host*disk*size" -title "Nomad client host disk size" -tags "creator:api,role:client,service:nomad,data-type:gauge,group:primary"
../../cmd/create_cgc/create_cgc -query "nomad*client*host*disk*used" -title "Nomad client host disk used" -tags "creator:api,role:client,service:nomad,data-type:gauge,group:primary"
../../cmd/create_cgc/create_cgc -query "nomad*client*host*disk*used_percent" -title "Nomad client host disk used_percent" -tags "creator:api,role:client,service:nomad,data-type:gauge,group:primary"

../../cmd/create_cgc/create_cgc -query "nomad*client*host*memory*available" -title "Nomad client host memory available" -tags "creator:api,role:client,service:nomad,data-type:gauge,group:primary"
../../cmd/create_cgc/create_cgc -query "nomad*client*host*memory*free" -title "Nomad client host memory free" -tags "creator:api,role:client,service:nomad,data-type:gauge,group:primary"
../../cmd/create_cgc/create_cgc -query "nomad*client*host*memory*total" -title "Nomad client host memory total" -tags "creator:api,role:client,service:nomad,data-type:gauge,group:primary"
../../cmd/create_cgc/create_cgc -query "nomad*client*host*memory*used" -title "Nomad client host memory used" -tags "creator:api,role:client,service:nomad,data-type:gauge,group:primary"

../../cmd/create_cgc/create_cgc -query "nomad*runtime*alloc_bytes" -title "Nomad runtime alloc_bytes" -tags "creator:api,role:client,service:nomad,data-type:gauge,group:primary"
../../cmd/create_cgc/create_cgc -query "nomad*runtime*free_count" -title "Nomad runtime free_count" -tags "creator:api,role:client,service:nomad,data-type:gauge,group:primary"
../../cmd/create_cgc/create_cgc -query "nomad*runtime*heap_objects" -title "Nomad runtime heap_objects" -tags "creator:api,role:client,service:nomad,data-type:gauge,group:primary"
../../cmd/create_cgc/create_cgc -query "nomad*runtime*malloc_count" -title "Nomad runtime malloc_count" -tags "creator:api,role:client,service:nomad,data-type:gauge,group:primary"
../../cmd/create_cgc/create_cgc -query "nomad*runtime*num_goroutines" -title "Nomad runtime num_goroutines" -tags "creator:api,role:client,service:nomad,data-type:gauge,group:primary"
../../cmd/create_cgc/create_cgc -query "nomad*runtime*sys_bytes" -title "Nomad runtime sys_bytes" -tags "creator:api,role:client,service:nomad,data-type:gauge,group:primary"
../../cmd/create_cgc/create_cgc -query "nomad*runtime*total_gc_pause_ns" -title "Nomad runtime total_gc_pause_ns" -tags "creator:api,role:client,service:nomad,data-type:gauge,group:primary"
../../cmd/create_cgc/create_cgc -query "nomad*runtime*total_gc_runs" -title "Nomad runtime total_gc_runs" -tags "creator:api,role:client,service:nomad,data-type:gauge,group:primary"

../../cmd/create_cgc/create_cgc -query "nomad*uptime" -title "Nomad uptime" -tags "creator:api,role:client,service:nomad,data-type:counter,group:primary"

## Histogram
../../cmd/create_cgc/create_cgc -query "nomad*runtime*gc_pause_ns" -title "Nomad runtime gc_pause_ns" -tags "creator:api,role:client,service:nomad,data-type:histogram,group:primary"
