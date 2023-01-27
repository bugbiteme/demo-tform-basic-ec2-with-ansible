terraform apply -auto-approve

echo "Waiting 20 seconds to make sure ec2 instances are ready"
sleep 1 && for i in {20..1}; do echo "$i" && sleep 1; done

ansible-playbook -i inventory playbook.yml