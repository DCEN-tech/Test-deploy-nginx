# Test-deploy-nginx

## Presentation

This project is only a use case whose purpose is to practice infrastructure and software deployments by using **Terraform** and **Ansible**.  
A Docker container has been choosen to serve as the host on which the deployment will be realized.

So, in order to implement the solution provided here, you will have first to ensure that pre-requisites described below are guaranteed.


## How does this solution work ?

* This solution will use Terraform to deploy the infrastructure.  
  In the context of this project, that means that Terraform will be used to create and start a Docker container that will be build on a Debian Linux OS.
  
* Once Terraform has been run and the Docker container created and started, then Ansible is called to execute the playbook that will deploy and configure Nginx inside the container.  

Refer to the section "Implementation" below to get more information on implementing this solution.


## Implementation

### Pre-requisites

   * Machine  
     you will need a machine on which is installed:

        - Docker
        - Terraform
        - Ansible
        - git

   * Connectivity  
     Ensure that your machine has access to internet.


### Procedure

Implement this procedure to test this solution.

* <u>Step 1</u>:  
  Clone this repository into your working machine (Please use a test machine: VM, ...) by running the following command:

  `git clone `
