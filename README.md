# terraform-waxonwaxoff

Terraform demo - exploring proper CI/CD principles with GibLab -
- Branching - 3 paths
- Merging - back to Master path in Gitlab
- Committing new TF code
- Setting proper .gitignore variables
- Mirroring a Gitlab to Github repo automatically

Exploring Terraform features - 
- Setting up external modules
- Running UserData in EC2 instances
- Exploring remote .tfstate usecases

If you wish to use this demo pay close attetion to the variables you must pass in order for this code to work:
 terraform init
 terraform plan -var-file="NAME.tfvars"
 terraform apply -var-file="NAME.tfvars"

This will create a two tier solution for a basic EC2 deployment for an Nginx webserver in a docker cluster hosted inside of the VM.

---------- Personal Note

Was a lot of fun and will be how I write my projects from this point going forward, Gitlab with private repos and Github for public hosting when I know the code works and is cleaned of any sensitive information.


