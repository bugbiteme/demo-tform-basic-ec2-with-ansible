# Instructions

You can use terraform on its own to spin up a number of Red Hat Enterprise Linux 
EC2 instances in AWS (version 8.4)

Feel free to set the variables how you see fit

Terraform also produces a dynamic Ansible inventory file that can be used in
playbooks for configuring these sytems.

As an example, I have created a playbook that installs httpd on each new system, along
with a hello message in index.html, diplaying the OS version

## Prerequisits
Install the following on your local system:
 - AWS cli
 - terraform
 - ansible (core)

## To run the terraform script on its own  
`terraform init`  
`terraform apply` (type "yes" when prompted)  

output shows all the public IP addresses, as well as a cli string to ssh into one of 
them.

delete everything by typing  
`terraform destroy`

## To run the ansible playbook
Once your ec2 instances have been provisioned, run the command  
`ansible-playbook -i inventory playbook.yml`  

This will accomplish installing and testing httpd

## To run them on one swoop
I have created a helper sctipt called 'provision-and-config.sh' that does it all together  

`sh ./provision-and-config.sh <optional number of instances>` 
examples:  
  
Just one ec2 instance (default)  
`sh ./provision-and-config.sh`  
  
ec2 instances  == 3
`sh ./provision-and-config.sh 3`

run `terraform destroy` afterwards when you are done  
