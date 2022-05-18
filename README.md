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

     this machine will be called the "workstation" on the rest of this document.

   * Connectivity  
     Ensure that your machine has access to internet.


### Procedure

The following procedure will consider that all the pre-requisites described above are already guaranteed.

* <u>Step 1</u>: Clone this repository  
  Place yourself inside a working directory then run the following command to clone this repository into your workstation (Please use a test machine: VM, ...):  
  `git clone https://github.com/DCEN-tech/Test-deploy-nginx.git iac-docker`  
  `cd iac-docker`

* <u>Step 2</u>: Provide SSH public key

  Terraform will first create an image from which a container will be instanciated.  
  To permit Ansible to connect and operate on the container, it is necessary to first permit SSH connection between Ansible (installed on the workstation) and the container. To do this, it will be necessary to enable passwordless connection by adding the ssh public key inside the container. This task will be managed (indirectly) by Terraform during the docker image construction. But for this to work, you have to provide the public ssh key that will be involved in SSH connection.  
  All you have to do is to copy the public ssh key inside the file: *./docker/id_rsa_pub* from *iac-docker* directory.

* <u>Step 2</u>: Deploy the infrastructure
    
  `terraform init`  
  This command will prepare environment for Terraform operations by first downloading needed providers.  
  In our case, we will use this provider: [docker - by kreuzwerker](https://registry.terraform.io/providers/kreuzwerker/docker/latest)  
  
  `terraform plan`  
  This command is optional and will permit to control what Terraform is about to do to deploy the infrastructure.  
  
  `terraform apply`  
  With this command, we instruct Terraform to deploy the infrastructure.  
  It is expected as a result that the container is created and started.  
  As now, the container should have SSH server enabled but not yet Nginx.  
  Ansible, now, will setup Nginx in the container.
  
* <u>Step 3</u>: Setup Nginx
  
  `cd ansible`  
  `ansible-playbook playbook_nginx_setup.yml`  
  With this command, Ansible will connect to the container via SSH to set up Nginx.  
  This is configured via an Nginx Ansible role, which will:
     1. Install Nginx
     2. Configure Nginx
     3. Generate an index.html file
     4. Start Nginx

* <u>Step 4</u>: Test 
 
  `curl -X GET http://localhost:8080`  
  This command will try to join the Nginx server (running from inside the container) from the workstation.  
  So for this, we submit an http GET request to the localhost (the workstation) on port 8080 (port that redirects to port 80 on the container).  
  If all works correctly you should then see the content of the index.html file.
  
  



