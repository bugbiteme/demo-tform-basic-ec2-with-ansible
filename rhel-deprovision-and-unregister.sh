

echo "Remove from Insighs and unregister RHEL"
ansible-playbook -i inventory rhel-unreg-insights.yml -v

echo "Delete all EC2 instances"
terraform destroy -auto-approve


