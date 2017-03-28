#!/bin/bash

###### Nomad Allocation Metrics
## Numeric


create_cgc -query "nomad*client*allocs*fabio*cpu*system" -title "Nomad Job fabio cpu system" -tags "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
create_cgc -query "nomad*client*allocs*fabio*cpu*throttled_periods" -title "Nomad Job fabio cpu throttled_periods" -tags "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
create_cgc -query "nomad*client*allocs*fabio*cpu*throttled_time" -title "Nomad Job fabio cpu throttled_time" -tags "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
create_cgc -query "nomad*client*allocs*fabio*cpu*total_percent" -title "Nomad Job fabio cpu total_percent" -tags "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
create_cgc -query "nomad*client*allocs*fabio*cpu*total_ticks" -title "Nomad Job fabio cpu total_ticks" -tags "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
create_cgc -query "nomad*client*allocs*fabio*cpu*user" -title "Nomad Job fabio cpu user" -tags "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
create_cgc -query "nomad*client*allocs*fabio*memory*cache" -title "Nomad Job fabio memory cache" -tags "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
create_cgc -query "nomad*client*allocs*fabio*memory*kernel_max_usage" -title "Nomad Job fabio memory kernel_max_usage" -tags "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
create_cgc -query "nomad*client*allocs*fabio*memory*kernel_usage" -title "Nomad Job fabio memory kernel_usage" -tags "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
create_cgc -query "nomad*client*allocs*fabio*memory*max_usage" -title "Nomad Job fabio memory max_usage" -tags "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
create_cgc -query "nomad*client*allocs*fabio*memory*rss" -title "Nomad Job fabio memory rss" -tags "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
create_cgc -query "nomad*client*allocs*fabio*memory*swap" -title "Nomad Job fabio memory swap" -tags "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"

create_cgc -query "nomad*client*allocs*hashiapp*cpu*system" -title "Nomad Job hashiapp cpu system" -tags "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
create_cgc -query "nomad*client*allocs*hashiapp*cpu*throttled_periods" -title "Nomad Job hashiapp cpu throttled_periods" -tags "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
create_cgc -query "nomad*client*allocs*hashiapp*cpu*throttled_time" -title "Nomad Job hashiapp cpu throttled_time" -tags "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
create_cgc -query "nomad*client*allocs*hashiapp*cpu*total_percent" -title "Nomad Job hashiapp cpu total_percent" -tags "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
create_cgc -query "nomad*client*allocs*hashiapp*cpu*total_ticks" -title "Nomad Job hashiapp cpu total_ticks" -tags "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
create_cgc -query "nomad*client*allocs*hashiapp*cpu*user" -title "Nomad Job hashiapp cpu user" -tags "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
create_cgc -query "nomad*client*allocs*hashiapp*memory*cache" -title "Nomad Job hashiapp memory cache" -tags "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
create_cgc -query "nomad*client*allocs*hashiapp*memory*kernel_max_usage" -title "Nomad Job hashiapp memory kernel_max_usage" -tags "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
create_cgc -query "nomad*client*allocs*hashiapp*memory*kernel_usage" -title "Nomad Job hashiapp memory kernel_usage" -tags "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
create_cgc -query "nomad*client*allocs*hashiapp*memory*max_usage" -title "Nomad Job hashiapp memory max_usage" -tags "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
create_cgc -query "nomad*client*allocs*hashiapp*memory*rss" -title "Nomad Job hashiapp memory rss" -tags "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
create_cgc -query "nomad*client*allocs*hashiapp*memory*swap" -title "Nomad Job hashiapp memory swap" -tags "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"

create_cgc -query "nomad*client*allocs*consul*cpu*system" -title "Nomad Job consul cpu system" -tags "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
create_cgc -query "nomad*client*allocs*consul*cpu*throttled_periods" -title "Nomad Job consul cpu throttled_periods" -tags "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
create_cgc -query "nomad*client*allocs*consul*cpu*throttled_time" -title "Nomad Job consul cpu throttled_time" -tags "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
create_cgc -query "nomad*client*allocs*consul*cpu*total_percent" -title "Nomad Job consul cpu total_percent" -tags "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
create_cgc -query "nomad*client*allocs*consul*cpu*total_ticks" -title "Nomad Job consul cpu total_ticks" -tags "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
create_cgc -query "nomad*client*allocs*consul*cpu*user" -title "Nomad Job consul cpu user" -tags "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
create_cgc -query "nomad*client*allocs*consul*memory*cache" -title "Nomad Job consul memory cache" -tags "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
create_cgc -query "nomad*client*allocs*consul*memory*kernel_max_usage" -title "Nomad Job consul memory kernel_max_usage" -tags "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
create_cgc -query "nomad*client*allocs*consul*memory*kernel_usage" -title "Nomad Job consul memory kernel_usage" -tags "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
create_cgc -query "nomad*client*allocs*consul*memory*max_usage" -title "Nomad Job consul memory max_usage" -tags "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
create_cgc -query "nomad*client*allocs*consul*memory*rss" -title "Nomad Job consul memory rss" -tags "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
create_cgc -query "nomad*client*allocs*consul*memory*swap" -title "Nomad Job consul memory swap" -tags "creator:api,role:allocation,service:nomad,data-type:guage,group:primary"
