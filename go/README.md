# circonus-hashi-ui-bits GO tools
<h2>Tools for Circonus and Hashicorp integration</h2>

Environment variables can be set so **apiurl, app, key,** and/or **nomadurl** parameters do not need to be set:
- CIRCONUS_API_KEY="API_TOKEN_FROM_YOUR_CIRCONUS_ACCOUNT"
- CIRCONUS_API_APP="Name_of_App"
- CIRCONUS_API_URL="https://api.circonus.com/v2/"
- NOMAD_API_URL="http://IP_OF_NOMAD_SERVER:4646/v1/allocations"

Each accepts the following flags:

- **apiurl** (string) Base Circonus API URL [https://api.circonus.com/] (CIRCONUS_API_URL)
- **app** (string) Circonus API Token App [nomad-metric-reaper] (CIRCONUS_API_APP)
- **debug** Enable Circonus API debugging
- **key**	(string) Circonus API Token Key [none] (CIRCONUS_API_KEY)
- **query** (string) The Query used to search

      sample: -query "nomad*runtime*gc_pause_ns"
- **title** (string) The name of the Cluster

      sample:  -title "Nomad runtime gc_pause_ns"
- **tags** (string) Tags to include

      sample: - tag "creator:api,role:client,service:nomad,data-type:histogram"
