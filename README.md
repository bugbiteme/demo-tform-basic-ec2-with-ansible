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

# For RHEL Insight Setup, run these scripts instead

Additional playbooks have been added to register your EC2 instances with a RHEL subscription
and add them to Insights inventory:  
- `rhel-reg-insights.yml`  

Usage:  
`ansible-playbook -i inventory rhel-reg-insights.yml --vault-id @prompt`  
  
Note:  
vault data set in `vars/reg-data.yml` and must be encrypted with `ansible-vault`

```
ansible-vault edit vars/reg-data.yml
.
.
username: <RH Subscription Username>
password: <RH Subscription Password>
```
  
Playbook to remove EC2 instances from the Insights inventory and unregister them:  
- `rhel-unreg-insights.yml`

Scripts to provision/deprovision and register/unregister have been created as well:
- `rhel-provision-and-register.sh`
- `rhel-deprovision-and-unregister.sh`

# Additional Notes

## How to activate RHEL with your subscription via the command line

### Prerequisites 
- Have a valid Red Hat Subscription

### Steps
- `sudo subscription-manager register --username <username> --password <password> --auto-attach`


## How to register your RHEL system with Red Hat Insights via the command line (RHEL 8.4)

### Prerequisites  
- Activate your RHEL (see above)
- [Check Insights on how to add based on version of RHEL](https://console.redhat.com/insights/registration)

### Steps
- `sudo insights-client --register`
or
- `sudo rhc connect -u <username> -p <password>`

## To unregister RHEL system with Insights (decommisioning)
- `sudo insights-client --unregister`

## To ungregister RHEL system from subscription
- `sudo subscription-manager unregister`

