
###### Consul Client Metrics
##Numeric



###### Consul Client Metrics
## Historgram

./create_cgc -query"consul*consul*http*GET*v1*agent*checks" -title "Consul http GET v1 agent checks" -tags "creator:api,role:client,service:consul,data-type:histogram,group:primary"
./create_cgc -query"consul*consul*http*GET*v1*agent*services" -title "Consul http GET v1 agent services" -tags "creator:api,role:client,service:consul,data-type:histogram,group:primary"
./create_cgc -query"consul*consul*http*GET*v1*health*state*_" -title "Consul http GET v1 health state _" -tags "creator:api,role:client,service:consul,data-type:histogram,group:primary"
./create_cgc -query"consul*consul*http*GET*v1*kv*_" -title "Consul http GET v1 kv _" -tags "creator:api,role:client,service:consul,data-type:histogram,group:primary"
./create_cgc -query"consul*consul*http*PUT*v1*agent*check*register" -title "Consul http PUT v1 agent check register" -tags "creator:api,role:client,service:consul,data-type:histogram,group:primary"
./create_cgc -query"consul*consul*http*PUT*v1*agent*service*register" -title "Consul http PUT v1 agent service register" -tags "creator:api,role:client,service:consul,data-type:histogram,group:primary"
./create_cgc -query"consul*runtime*gc_pause_ns" -title "Consul runtime gc_pause_ns" -tags "creator:api,role:client,service:consul,data-type:histogram,group:primary"
./create_cgc -query"consul*serf*queue*Event" -title "Consul serf queue Event" -tags "creator:api,role:client,service:consul,data-type:histogram,group:primary"
./create_cgc -query"consul*serf*queue*Intent" -title "Consul serf queue Intent" -tags "creator:api,role:client,service:consul,data-type:histogram,group:primary"
./create_cgc -query"consul*serf*queue*Query" -title "Consul serf queue Query" -tags "creator:api,role:client,service:consul,data-type:histogram,group:primary"
./create_cgc -query"consul*serf*snapshot*appendLine" -title "Consul serf snapshot appendLine" -tags "creator:api,role:client,service:consul,data-type:histogram,group:primary"
./create_cgc -query"consul*serf*snapshot*compact" -title "Consul serf snapshot compact" -tags "creator:api,role:client,service:consul,data-type:histogram,group:primary"