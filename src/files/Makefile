#!/usr/bin/make

################################################################################
# Makefile for applying the Infrastructure 

# The parameters passed to Make should be:
#
#     stack = STACK
#     environment = ENVIRONMENT
#
################################################################################

GNU_ECHO ?= /bin/echo
TF_BIN := tofu

# Control whether to supress the echo of a command; supressed by default
Q ?= @

# The account ID of the account that hosts the tf backend, tfstate & lock table
STATE_ACCOUNT_ID ?= <YOUR_AWS_ACCOUNT_ID>

# Region where the resource is created
region := eu-west-2

# S3 bucket where the TF state data is stored
bucket := notifycal-${region}-tf-state

# S3 key where the tf state data is stored
tfstate_key := ${region}/${stack}.tfstate

# Where does the code live?
stack_path = "stacks/${stack}"

# Parameters passed to tf
tf_args ?= -var-file="../../configs/${environment}/common.tfvars" -var-file="../../configs/${environment}/${stack}.tfvars" -var "environment=${environment}" -var "stack=${stack}"

ifdef TF_LOCK_TIMEOUT
  tf_lock := -lock-timeout=${TF_LOCK_TIMEOUT}
else
  tf_lock :=
endif

ifdef TF_RESOURCE
  tf_target := -target=${TF_RESOURCE}
else
  tf_target :=
endif

# Role ARN

# role_arn := arn:aws:iam::${STATE_ACCOUNT_ID}:role/TerraformState #TODO: use when it is created
# role_arn := arn:aws:iam::${STATE_ACCOUNT_ID}:role/CIAccessRole

################################################################################
# Default target

.PHONY: all
all: validate plan apply

################################################################################
# Remove the generated backend.tf file

.PHONY: clean
clean:
	${Q}rm -f ${stack_path}/backend.tf
	${Q}rm -f ${stack_path}/common_*.tf
	${Q}rm -rf ${stack_path}/.terraform

################################################################################
# Check that the values supplied on the command line are present and, where
# possible, correct.

.PHONY: check
check: clean
	${Q}echo -n "Checking for region setting ... "
	${Q}test -n "${region}" || (echo "no region setting" && exit 1)
	${Q}echo "OK"
	${Q}echo -n "Checking for bucket setting ... "
	${Q}test -n "${bucket}" || (echo "no bucket setting" && exit 1)
	${Q}echo "OK"
	${Q}echo -n "Checking for stack setting ... "
	${Q}test -n "${stack}" || (echo "no stack setting" && exit 1)
	${Q}test -d ${stack_path} || (echo "The stack does not exist" && exit 1)
	${Q}echo "OK"
	${Q}echo -n "Checking for environment setting ..."
	${Q}test -n "${environment}" || (echo "no environment setting" && exit 1)
	${Q}test -d "configs/${environment}" || (echo "No environment config exists for that environment" && exit 1)
	${Q}echo "OK"
	${Q}echo ""

################################################################################
# Create the backend configuration file (note that is declared phony to force
# the file to be recreated every time as it contains data from the Make command
# line).
# This is awaiting roles and dynamodb

.PHONY: backend.tf

define BACKEND_TF
terraform {
	backend "s3" {
		region = "${region}"
		bucket = "${bucket}"
		key = "${tfstate_key}"
		encrypt = "true"
		role_arn = "${role_arn}"
		dynamodb_table = "terraform_statelock"
	}
}
endef
export BACKEND_TF

backend.tf: check clean
	${Q}${GNU_ECHO} "$$BACKEND_TF" > ${stack_path}/backend.tf || (echo "Failed to write backend config to backend.tf" && exit 1)
	${Q}echo "Set up S3 remote state from s3 bucket ${bucket}, key env:/${environment}/${tfstate_key}"

################################################################################
# Copy common files into the stacks dir
.PHONY: common
common:
	cp common/locals.tf ${stack_path}/common_locals.tf
	cp common/variables.tf ${stack_path}/common_variables.tf

################################################################################
# Initialisation - initialise tf

.PHONY: init
init: check backend.tf common
	${Q}cd ${stack_path} && \
	tfenv install && \
	${TF_BIN} init -reconfigure || (echo "TF init failed" && exit 1) && \
	${TF_BIN} workspace select ${environment} || ${TF_BIN} workspace new ${environment} && \
	${TF_BIN} init -reconfigure || (echo "TF init failed" && exit 1) && \
	${TF_BIN} get -update=true || (echo "TF get failed" && exit 1)
	${Q}echo "Formatting"
	${Q}cd ${stack_path} && ${TF_BIN} fmt

################################################################################
# Validate the tf code

.PHONY: validate
validate: init
	${Q}echo "Running a validate"
	${Q}cd ${stack_path} && ${TF_BIN} validate ${tf_args}
	${Q}echo "Validation passed"

################################################################################
# Run tf plan

.PHONY: plan
plan: init
	${Q}echo "Running a plan on ${stack_path}"
	${Q}echo "Command to execute: ${TF_BIN} plan ${tf_args} ${tf_lock} ${tf_target}"

	${Q}cd ${stack_path} && ${TF_BIN} plan ${tf_args} ${tf_lock} ${tf_target}

################################################################################
# Run tf refresh

.PHONY: refresh
refresh: init
	${Q}echo "Running a refresh"
	${Q}cd ${stack_path} &&  ${TF_BIN} refresh ${tf_args} ${tf_lock}

################################################################################
# Run tf apply

.PHONY: apply
apply: init
	${Q}echo "Applying..."
	${Q}echo "Command to execute: ${TF_BIN} apply ${autoapprove} ${tf_args} ${tf_lock} ${tf_target}"

	${Q}cd ${stack_path} && ${TF_BIN} apply ${autoapprove} ${tf_args} ${tf_lock} ${tf_target}

################################################################################
# Run tf destroy

.PHONY: destroy
destroy: init
	${Q}test "${AUTOMATED_DELETE}" = "true" || (echo "Delete operation not authorised"; exit 1)
	${Q}test "${environment}" != "prod" || (echo "Production environment cannot be destroyed"; exit 1)

	${Q}echo "Destroying..."
	${Q}cd ${stack_path} && ${TF_BIN} destroy ${autoapprove} ${tf_args} ${tf_lock}
