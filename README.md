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
├── terraform/            # Infrastructure as Code (IaC)
│   ├── main.tf           # Root terraform file
│   ├── terraform.tfvars  # Variables to be defined automatically during runtime
│   ├── variables.tf
│   └── outputs.tf
├── ansible/
│   ├── inventory.ini     # List of EC2 instance IPs
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
    ```
    To destroy all:
    ```
    $ terraform destroy
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
    ```
