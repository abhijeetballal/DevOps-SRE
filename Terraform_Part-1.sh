1. Which IaaC tool you are using? Do you have exp with Terraform?
I am familir with both Cloud Native IaaC Tools like AWS CF & Azure ARM Templates.
From past 3 years we are using Terraform for IaaC.

2. What are the frequently used commands with Terraform?
terraform init
terraform fmt # Format the code
terraform validate # Find any syntax errors
terraform plan # Dry Run
terraform apply # Execute the code

3. What exactly Terraform Init does?
It will check for the provider plugins and download the plugins if not available.
It will also download the modules if any.
If also configure the backend if you have mentioned in the code mostly remote backend.

4. How to execute Terraform apply in non-interactive mode?
terraform apply --auto-approve #This is used as part of CI/CD pipeline.

5. What is a State file in Terraform?
Terraform use state file to know what exactly the current state of the infrastructure andd its a JSON file. By default it will be created as terraform.tfstate file locally.
Its recommended to use remote backend to store the state file. Some of the remote backends are S3, Azure Blob Storage, GCS etc.

6. Where do you store the state file?
I have worked on projects based on AWS and Azure. While working with AWS, the state file is stored in S3 bucket and locked with DynamoDB. While working with Azure, the state file is stored in Azure Blob Storage and the good thing about Azure Blob Storage is that it has inbuilt locking mechanism.
  backend "s3" {
    bucket = "awsb63data"
    key    = "terraform-functions.tfstate"
    region = "us-east-1"
  }
backend "azurerm" {
    storage_account_name = "azb63data"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }

7. What happens if the state file is deleted?
If the state file is deleted, Terraform will not know the current state of the infrastructure and if you perform terraform apply, it will try to create the resources again which are already created. So, it is always recommended to store the state file in a remote backend and take a backup of it.

If there is no backup of the state file, you can import the existing resources to the state file using terraform import command.

Its recomanded to backup S3 bucket and Azure Blob Storage using AWS backup and Azure Backup respectively.

8. How to edit the state file? or How do you rename the resource in Terraform?
You can't edit the state file directly. If you want to edit the state file, you can use terraform state command. You can use terraform state list to list the resources and terraform state show to show the details of the resource.

terraform state mv aws_security_group.allow_all aws_security_group.allow_all_new

9. I want to perform terraform create & destroy for a specific resource, how can I do that?
terraform apply -target=aws_security_group.allow_all
terraform destroy -target=aws_security_group.allow_all

10. I want to perform terraform destory but I don't want to delete a specific resource, how can I do that?
We need to do it two steps. First, we need to remove the resource from the state file using 
a.terraform state rm aws_s3_bucket.bucket_name
b.Remove/Comment the S3 resource from the Terraform code.
c.Then, we can perform terraform destroy.

11. Someone from my team made manual changes to the infrastructure, what will happen if I run terraform apply?
If someone made manual changes to the infrastructure, Terraform will not know the current state of the infrastructure. So, it is always recommended to run terraform plan before running terraform apply. Terraform plan will show the changes which will be made to the infrastructure. If you see any manual changes, you can import the existing resources to the state file using terraform import command.

If you perform terraform apply without running terraform plan, Terraform will delete the changes.

12. What Terraform Refresh does or How Terraform Refresh works or How to identify the manual changes made to the infrastructure?
Terraform refresh will us to identify if any manual changes are made to the infrastructure. 
terraform plan --refresh-only # This will only refresh the state file and will not make any changes to the infrastructure.
If the changes are needed then we need to incorporate the changes in the Terraform code.

13. What is the difference between Terraform variables and Terraform Tfvars?
  var.vpc_name
- Variables.tf is used to define/declare the variables and its type. Its not mandatory to have the same name as variables.tf. You can have any filename. You can also provide default values to the variables but its not recommended.

variable "vpc_name" {
  type = string
  default = "dempvpc1"
}

We can pass the values to the variables using Terraform.tfvars file. We can also pass the values using command line arguments using teraform apply --var 'vpc_name=dempvpc1' which has higher precedence than Terraform.tfvars file.

14. Can I have multiple-tfvars files?
Yes, you can have multiple tfvars files. Default file name is terraform.tfvars. We can also use custom filenames as show below.
terraform apply -var-file=dev.tfvars -var-file=prod.tfvars

15. I want Terraform use multiple tfvars files automatically like terraform.tfvars. How can I do that?
dev1.auto.tfvars
dev2.auto.tfvars
dev3.auto.tfvars
dev4.auto.tfvars

16. What is terraform tfvars precedence?

Environment variables #TF_VAR_vpc_name=dempvpc1
The terraform.tfvars file, if present.
The terraform.tfvars.json file, if present.
Any *.auto.tfvars or *.auto.tfvars.json files, processed in lexical order of their filenames.
Any -var and -var-file options on the command line, in the order they are provided. (This includevariables set by a Terraform Cloud workspace.)

17. I want to deploy infra in mutliple AWS regions which the same code at the same time, how can I do that?
Terraform alias can be used to deploy the same code in multiple regions. We can use the same code and use alias to deploy the resources in multiple regions.

provider "aws" {
  alias = "ca-central-1"
  region = "ca-central-1"
  profile = var.aws_profile
}

provider "aws" {
   alias = "other-ca-central-1"
   region = "ca-central-1"
   profile = var.aws_other_profile
}

18. I have created aws_secret manually. Using Terraform how to access it?
19. I have a route53 domain name whcih already exists. How to create records using Terraform?

For using Existing resources, we need to use data sources. Data sources are used to fetch the information about the existing resources. We can use data sources to fetch the information about the existing resources and use it in the Terraform code.
Eg: 
data "aws_route53_zone" "awsb63" {
  name = "awsb63.com"
}

resource "aws_route53_record" "awsb63" {
  zone_id = data.aws_route53_zone.awsb63.zone_id
  name    = "awsb63.com"
  type    = "A"
  ttl     = "300"
  records = ["hello123"]

The important thing about data sources is that it will not bring the resources under Terraform management. It will only fetch the information about the existing resources. Thats its not adding the resouce in the state file.

20. How to bring a manual resource under Terraform management?
We can use terraform import command to bring the manual resources under Terraform management. Thats means if you perform terraform destroy, it will delete the resources.

21. How is your Terraform Folder Structure?
A. In my experiance I have noticed mutiple folder structures. 
We mostly use modules.
If all Dev, QA, Prod are same, then we use single folder structure with workspaces along with tfvars files.
If Dev, QA, Prod are different, then we use different folders for each environment.

22. How to import large number of resources to Terraform?
We can use terraformer tool to import the resources to Terraform. Terraformer is a tool to generate tf files from the existing resources. We can use terraformer to import the resources to Terraform.

First, identity the dependencies between the resources and then import the resources to Terraform.
Second, import the resources to Terraform using terraform import command.


