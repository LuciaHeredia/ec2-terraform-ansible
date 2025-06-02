# 📦 AWS EC2 instances with Terraform and Ansible
This project automates the deployment and configuration of multiple **AWS EC2 instances* using **Terraform** and **Ansible**.

## What It Does:
1. Provision Infrastructure with **Terraform**:
    - Creates 3 **EC2 instances** in **AWS**.
    - Generates and uses an *SSH key pair*.
    - Optionally applies basic provisioning steps.
2. Generate **Ansible** Inventory Automatically:
    - Extracts public IPs of the **EC2 instances**.
    - Creates a ready-to-use *inventory.ini* file for **Ansible**.
3. Manage Configuration with **Ansible**:
    - Connects via *SSH* to configure and manage the **EC2 instances**.
    - Runs user-defined *playbooks* (e.g., updates, installs).

## Folders Structure:
```
ec2-terraform-ansible/
│
├── terraform/                 # Infrastructure as Code (IaC)
│   ├── main.tf                # Root terraform file
│   ├── terraform.tfvars       # Variables to be defined automatically during runtime
│   ├── variables.tf
│   ├── outputs.tf
│   └── generate_inventory.sh  # Connects Terraform to Ansible by generating a dynamic inventory
│
├── ansible/                   # Automates configuration of EC2 instances using Ansible over SSH
│   ├── inventory.ini          # List of EC2 instance IPs
│   ├── playbook.yml           # Updates packages on EC2 instances
│   └── playbook-nginx.yml     # Installs and configures NGINX on Ubuntu EC2 instances
│
├── .gitignore                 
└── README.md
```

## Prerequisites:
* **Terraform** installed.
* **Ansible** installed.
* **AWS** credentials configured.
* *SSH key pair* available (or auto-generated).
* *jq* installed (used in generate_inventory script).

## How to use:
1. Clone this project.
2. Deploy with Terraform:
    ```
    $ cd terraform
    $ terraform init
    $ terraform apply -auto-approve
    ```
3. Automatically export IPs for Ansible with Shell script:
    - Make script executable (first time only):
    ```
    $ chmod +x generate_inventory.sh
    ```
    - Run script:
    ```
    $ ./generate_inventory.sh
    $ cd ..
    ```
4. Run Ansible:
    ```
    $ cd ansible
    $ ansible-playbook -i inventory.ini playbook.yml
    $ ansible-playbook -i inventory.ini playbook-nginx.yml
    ```
5. To destroy all:
    ```
    $ cd ..
    $ cd terraform
    $ terraform destroy -auto-approve
    ```