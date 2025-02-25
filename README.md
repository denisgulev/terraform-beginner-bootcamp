# Terraform Beginner Bootcamp 2023

### Install Terraform

Head to official docs (https://developer.hashicorp.com/terraform/install) and install Terraform for your OS.

### Install AWS cli

1. Install AWS cli following the official documentation

2. Create an AWS account; head to IAM and create a user, different from root user, and take not of AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY.

3. create local ENV vars using `export <ENV_VAR>=<value>` for:
    - AWS_ACCESS_KEY_ID 
    - AWS_SECRET_ACCESS_KEY 
    - AWS_DEFAULT_REGION 

4. To verify is aws is installed, execute:
    - `aws --version`

5. To verify user is set correctly:
    - `aws sts get-caller-identyty`

### Terraform Basics

Terraform soruces providers and modules from the Terraform registry, located at [registry.terraform.io] (https://registry.terraform.io/)

- Providers -> interfaces to APIs that allow to create resources
- Modules   -> contain multiple resources, allowing to package and re-use them

#### Terraform init

`terraform init`
downloads the binaries for the providers we will use in the project

#### Terraform plan

`terraform plan`
generates a changeset about the state of the infrastructure and resources that will be changed; this will NOT carry out the proposed changes

#### Terraform apply

`terraform apply`
runs a plan and passes the changes to be executed by terraform

#### Terraform destroy

`terraform destroy`
destroy the resources

#### Terraform Lock Files

`.terraform.lock.hcl`
contains the locked versioning for the providers or modulues that should be used with this project.

The Terraform Lock File should be committed to your Version Control System (VSC) eg. Github

#### Terraform State Files

`.terraform.tfstate`
contains information about the current state of the infrastructure

should NOT be committed to VSC

`.terraform.tfstate.backup` is the previous state file state.

#### Terraform Directory

`.terraform` directory contains binaries of terraform providers.