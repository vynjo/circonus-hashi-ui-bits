module "hashiapp" {
  source      = "../lib/nomad-job-service"
  environment = "${var.environment}"
  human_name  = "Hashiapp v1 v2 test app"
  job_name    = "hashiapp"
  task_group  = "console"
  job_tags    = ["app:hashiapp", "service:hashistack", "source:gcp-cjm"]
}

/*
module "job-atlas-frontend" {
  source      = "../lib/nomad-job-service"
  environment = "${var.environment}"
  human_name  = "Atlas Frontend (rails)"
  job_name    = "atlas"
  task_group  = "frontend"
  job_tags    = ["app:atlas", "app:atlas-frontend"]
}

module "job-atlas-worker" {
  source      = "../lib/nomad-job-service"
  environment = "${var.environment}"
  human_name  = "Atlas Worker"
  job_name    = "atlas"
  task_group  = "worker"
  job_tags    = ["app:atlas", "app:atlas-worker"]
}

module "job-binstore" {
  source      = "../lib/nomad-job-service"
  environment = "${var.environment}"
  human_name  = "Binstore"
  job_name    = "binstore"
  task_group  = "binstore"
  job_tags    = ["app:binstore"]
}

module "job-cypress" {
  source      = "../lib/nomad-job-system"
  environment = "${var.environment}"
  human_name  = "Cypress"
  job_name    = "cypress"
  task_group  = "cypress"
  job_tags    = ["app:cypress"]
}

module "job-deployer" {
  source      = "../lib/nomad-job-service"
  environment = "${var.environment}"
  human_name  = "Deployer"
  job_name    = "deployer"
  task_group  = "deployer"
  job_tags    = ["app:deployer"]
}

/*
# Running job, but no data
module "job-echo" {
  source = "../lib/nomad-job-service"
  environment = "${var.environment}"
  human_name = "Echo"
  job_name = "echo"
  task_group = "echo"
  job_tags = [ "app:echo" ]
}
*/
/*
module "job-logstream" {
  source      = "../lib/nomad-job-service"
  environment = "${var.environment}"
  human_name  = "Logstream"
  job_name    = "logstream"
  task_group  = "logstream"
  job_tags    = ["app:logstream"]
}

module "job-packer-build-manager" {
  source      = "../lib/nomad-job-service"
  environment = "${var.environment}"
  human_name  = "Packer Build Manager"
  job_name    = "packer-build-manager"
  task_group  = "packer-build-manager"
  job_tags    = ["app:packer-build-manager"]
}

module "job-packer-build-manager-docker" {
  source      = "../lib/nomad-job-service"
  environment = "${var.environment}"
  human_name  = "Packer Build Manager (Docker Edition)"
  job_name    = "pbm-docker"
  task_group  = "pbm-docker"
  job_tags    = ["app:packer-build-manager-docker"]
}

module "job-pgbouncer" {
  source      = "../lib/nomad-job-service"
  environment = "${var.environment}"
  human_name  = "pgbouncer"
  job_name    = "pgbouncer"
  task_group  = "pgbouncer"
  job_tags    = ["app:pgbouncer"]
}

module "job-slug-extract" {
  source      = "../lib/nomad-job-service"
  environment = "${var.environment}"
  human_name  = "Slug Extract"
  job_name    = "slug-extract"
  task_group  = "slug-extract"
  job_tags    = ["app:slug-extract"]
}

module "job-slug-ingress" {
  source      = "../lib/nomad-job-service"
  environment = "${var.environment}"
  human_name  = "Slug Ingress"
  job_name    = "slug-ingress"
  task_group  = "slug-ingress"
  job_tags    = ["app:slug-ingress"]
}

module "job-slug-merge" {
  source      = "../lib/nomad-job-service"
  environment = "${var.environment}"
  human_name  = "Slug Merge"
  job_name    = "slug-merge"
  task_group  = "slug-merge"
  job_tags    = ["app:slug-merge"]
}

module "job-storagelocker" {
  source      = "../lib/nomad-job-service"
  environment = "${var.environment}"
  human_name  = "Storagelocker"
  job_name    = "storagelocker"
  task_group  = "storagelocker"
  job_tags    = ["app:storagelocker"]
}

module "job-terraform-build-manager" {
  source      = "../lib/nomad-job-service"
  environment = "${var.environment}"
  human_name  = "Terraform Build Manager"
  job_name    = "terraform-build-manager"
  task_group  = "terraform-build-manager"
  job_tags    = ["app:terraform-build-manager"]
}

module "job-terraform-build-manager-docker" {
  source      = "../lib/nomad-job-service"
  environment = "${var.environment}"
  human_name  = "Terraform Build Manager (Docker Edition)"
  job_name    = "tbm-docker"
  task_group  = "tbm-docker"
  job_tags    = ["app:terraform-build-manager-docker"]
}

module "job-terraform-state-parser" {
  source      = "../lib/nomad-job-service"
  environment = "${var.environment}"
  human_name  = "Terraform State Parser"
  job_name    = "terraform-state-parser"
  task_group  = "terraform-state-parser"
  job_tags    = ["app:terraform-state-parser"]
}*/
