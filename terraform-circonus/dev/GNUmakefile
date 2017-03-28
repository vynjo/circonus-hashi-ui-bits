TFVARS=.circonus.tfvars
TFSTATE=.terraform.tfstate
TFPLAN=.circonus.tfplan

plan::
	terraform get -update=true
	terraform plan -out=${TFPLAN} -var-file=${TFVARS} -state=${TFSTATE}

plan-target::
	terraform get -update=true
	terraform plan -out=${TFPLAN} -var-file=${TFVARS} -state=${TFSTATE} -target=${TARGET}

taint-target::
	terraform taint -state=${TFSTATE} -module=${MODULE} ${TARGET}

apply::
	terraform apply -state-out=${TFSTATE} ${TFPLAN}

# Example import to reuse while debugging:
#
#import::
#	terraform import -state=${TFSTATE} module.consul-server3.circonus_check.consul /check_bundle/170496

refresh::
	terraform refresh

show::
	terraform show ${TFSTATE}

fmt::
	terraform fmt .

destroy::
	# terraform destroy -force

clean:: destroy
	# rm -f ${TFPLAN} ${TFSTATE} crash.log
