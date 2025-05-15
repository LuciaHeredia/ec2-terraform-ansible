# In process...
# 📦 AWS EC2 instances with Terraform and Ansible

## Folders Structure:
```
ec2-terraform-ansible/
├── terraform/            # Infrastructure as Code (IaC)
│   ├── main.tf           # Root terraform file
│   ├── terraform.tfvars  # Variables to be defined automatically during runtime
│   ├── variables.tf
│   └── outputs.tf
├── ansible/
│   ├── inventory.ini
│   └── playbook.yml
└── README.md
```
## How to use:
1. Clone this project.
2. Deploy with Terraform:
    ```
    $ cd terraform
    $ terraform init
    $ terraform apply -auto-approve
    $ cd ..
    ```
    To destroy all:
    ```
    $ terraform destroy
    ```
