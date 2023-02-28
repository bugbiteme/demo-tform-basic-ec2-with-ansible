
#terraform apply -var 'instances=<number of instances>'
if [ -z "$1" ]; then
    echo "Creating a single EC2 Instance"
    terraform apply -auto-approve
else
    echo "Creating $1 EC2 Instances"
    terraform apply -auto-approve  -var "instances=$1"
fi

#terraform apply -auto-approve

echo "Waiting 20 seconds to make sure ec2 instances are ready"
sleep 1 && for i in {20..1}; do echo "$i" && sleep 1; done

ansible-playbook -i inventory rhel-reg-insights.yml --vault-id @prompt