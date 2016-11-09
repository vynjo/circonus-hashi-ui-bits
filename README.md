# circonus-hashi-ui-bits
<h2>Tools for Circonus and Hashicorp integration</h2>

Current tools include:

<h3>GO Version for:</h3>
<p>- Deactivation of "Complete" Allocations.</p>
   **go/deactivate-complete-allocs.go**

and Linux executable - **deactivate-complete-allocs**
<p>Requires environment variables:</p>
      CIRCONUS_API_TOKEN="API_TOKEN_FROM_YOUR_CIRCONUS_ACCOUNT"
      CIRCONUS_API_APP="Name_of_App"
      CIRCONUS_API_URL="https://api.circonus.com/v2/"
      NOMAD_URL="http://IP_OF_NOMAD_SERVER:4646/v1/allocations"

 <h3> Node.js versions for</h3>
- node/create-cluster.js
- node/deactivate-complete-lost-allocs.js
- node/deactivate-metrics.js
- node/deactivate-complete-allocs.js
- node/deactivate-lost-allocs.js
- node/find-running-allocations.js

Requires circonusapi2 and stdio
- npm install circonusapi2
- npm install stdio
