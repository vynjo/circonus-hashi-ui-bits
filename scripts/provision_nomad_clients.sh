
###### Nomad Client Metrics
##Numeric


./create_cgc -query "nomad*client*host*cpu*cpu0*idle" -title "Nomad client host cpu cpu0 idle" -tags "creator:api, role:client, service:nomad, data-type:numeric, category:primary"
./create_cgc -query "nomad*client*host*cpu*cpu0*system" -title "Nomad client host cpu cpu0 system" -tags "creator:api, role:client, service:nomad, data-type:numeric, category:primary"
./create_cgc -query "nomad*client*host*cpu*cpu0*total" -title "Nomad client host cpu cpu0 total" -tags "creator:api, role:client, service:nomad, data-type:numeric, category:primary"
./create_cgc -query "nomad*client*host*cpu*cpu0*user" -title "Nomad client host cpu cpu0 user" -tags "creator:api, role:client, service:nomad, data-type:numeric, category:primary"
./create_cgc -query "nomad*client*host*disk*/dev/sda1*available" -title "Nomad client host disk /dev/sda1 available" -tags "creator:api, role:client, service:nomad, data-type:numeric, category:primary"
./create_cgc -query "nomad*client*host*disk*/dev/sda1*inodes_percent" -title "Nomad client host disk /dev/sda1 inodes_percent" -tags "creator:api, role:client, service:nomad, data-type:numeric, category:primary"
./create_cgc -query "nomad*client*host*disk*/dev/sda1*size" -title "Nomad client host disk /dev/sda1 size" -tags "creator:api, role:client, service:nomad, data-type:numeric, category:primary"
./create_cgc -query "nomad*client*host*disk*/dev/sda1*used" -title "Nomad client host disk /dev/sda1 used" -tags "creator:api, role:client, service:nomad, data-type:numeric, category:primary"
./create_cgc -query "nomad*client*host*disk*/dev/sda1*used_percent" -title "Nomad client host disk /dev/sda1 used_percent" -tags "creator:api, role:client, service:nomad, data-type:numeric, category:primary"
./create_cgc -query "nomad*client*host*memory*available" -title "Nomad client host memory available" -tags "creator:api, role:client, service:nomad, data-type:numeric, category:primary"
./create_cgc -query "nomad*client*host*memory*free" -title "Nomad client host memory free" -tags "creator:api, role:client, service:nomad, data-type:numeric, category:primary"
./create_cgc -query "nomad*client*host*memory*total" -title "Nomad client host memory total" -tags "creator:api, role:client, service:nomad, data-type:numeric, category:primary"
./create_cgc -query "nomad*client*host*memory*used" -title "Nomad client host memory used" -tags "creator:api, role:client, service:nomad, data-type:numeric, category:primary"
./create_cgc -query "nomad*runtime*alloc_bytes" -title "Nomad runtime alloc_bytes" -tags "creator:api, role:client, service:nomad, data-type:numeric, category:primary"
./create_cgc -query "nomad*runtime*free_count" -title "Nomad runtime free_count" -tags "creator:api, role:client, service:nomad, data-type:numeric, category:primary"
./create_cgc -query "nomad*runtime*heap_objects" -title "Nomad runtime heap_objects" -tags "creator:api, role:client, service:nomad, data-type:numeric, category:primary"
./create_cgc -query "nomad*runtime*malloc_count" -title "Nomad runtime malloc_count" -tags "creator:api, role:client, service:nomad, data-type:numeric, category:primary"
./create_cgc -query "nomad*runtime*num_goroutines" -title "Nomad runtime num_goroutines" -tags "creator:api, role:client, service:nomad, data-type:numeric, category:primary"
./create_cgc -query "nomad*runtime*sys_bytes" -title "Nomad runtime sys_bytes" -tags "creator:api, role:client, service:nomad, data-type:numeric, category:primary"
./create_cgc -query "nomad*runtime*total_gc_pause_ns" -title "Nomad runtime total_gc_pause_ns" -tags "creator:api, role:client, service:nomad, data-type:numeric, category:primary"
./create_cgc -query "nomad*runtime*total_gc_runs" -title "Nomad runtime total_gc_runs" -tags "creator:api, role:client, service:nomad, data-type:numeric, category:primary"
./create_cgc -query "nomad*uptime" -title "Nomad uptime" -tags "creator:api, role:client, service:nomad, data-type:numeric, category:primary"

## Histogram
#./create_cgc -query "nomad*runtime*gc_pause_ns" -title "Nomad runtime gc_pause_ns" -tags "creator:api, role:client, service:nomad, data-type:histogram, category:primary"