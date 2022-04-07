# Test Terraform PlanA Techonologies

To work with this project you will need:

| Binary    | Source                                                                                           | Version | Checked Version    |
| --------- | ------------------------------------------------------------------------------------------------ | ------- | ------------------ |
| Terraform | [Terraform](https://www.terraform.io/downloads)                                                  | 1.0.15  | :white_check_mark: |
| AWS CLI   | [Install AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) | 2.2.15  | :white_check_mark: |

You will need to configure the AWS Profile `default` on you `/.aws/credentials` or you can change the `profiles` from providers and backend.

To configure the AWS Profile `default`, you can use the `aws cli` command. Example:

```
aws configure
```

## Configuration

You'll need to create a S3 Bucket on AWS. You can create it using AWS Painel or using AWS CLI. Feel free to choose the best way to you doing that.

You will need to configure the terraform backend destine. This project is desing to state the files on S3 Backend, and to configure it you will need to change the pattern `{BUCKET_USED_TO_STORE_TERRAFORM_STATE}` on these files:

| Path | Filename    |
| ---- | ----------- |
| vpc  | versions.tf |
| eks  | versions.tf |

Example:

vpc/version.tf

```
terraform {
  required_version = ">= 1.0"
  backend "s3" {
    bucket = "basic-bucket-terraform-state"
    region = "us-east-1"
    key    = "vpc/terraform.tfstate"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.8.0"
    }
  }
}
```

## Running Terraform

### Init

We need to run the command terraform `init` to load the backend state and load the necessary modules/providers used by terraform. To it we will run terraform init on each folder.

Terraform Init:

```
cd vpc/
terraform init
```

```
cd eks/
terraform init
```

### Workspace

Once the terraform is initated we need to select the workspace. We could use the `default` namespace, but we won't use it. We'll create a new workspace called `production`/`staging`, using the environment name to decide which name is better.


#### New Workspace

We should create a workspace, if we don't have one.

To create a new workspace we use:

```
cd vpc/
terraform workspace new staging
```

```
cd eks/
terraform workspace new staging
```

#### Select Workspace

With our workspace created, we can select it.

To use a select workspace we can use:

```
cd vpc/
terraform workspace select staging
```

```
cd eks/
terraform workspace select staging
```

### Plan 

Now, we will see what is changing in our infrastructure. It's important to know what will be changed and if we need to fix something. If neeeded we can create an output plan, to use it on our apply but this depends how you are automating things.

```
cd vpc/
terraform plan
```

```
cd eks/
terraform plan
```

### Apply

Once we had checked everything arround these files we can apply it. On automation we can use `--auto-approve` to automatic approve our apply and we can choose an output plan to apply.

```
cd vpc/
terraform plan
```

```
cd eks/
terraform plan
```

_Obs_: Always apply first `vpc` and then the `eks`, because `eks` depends of folder `vpc`.
