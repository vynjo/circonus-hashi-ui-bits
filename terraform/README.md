# Terraform & Circonus

## Monitoring as Code

This is the Terraform repo for all things Circonus. It is actively being built out.

### Usage

There is one directory per Circonus account (e.g. `dev`). This can be duplicated to have identical environments (prod, staging, etc.)

Inside of `dev` is
- a top-level `GNUMakefile` that handles the manual execution of the Terraform.
- `lib` directory with sample implementations
     - aws
     - circonus account info
     - consul cluster
     - consul server
     - nomad jobs
     - nomad server & client

Lots of TBD's:
- Vault Server monitoring
- alerts are currently commented out
     - slack
     - pagerduity
     - sms
     - email
- PostgreSQL
- MySQL
- and more circonus check types



