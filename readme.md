docker-compose up -d
chmod +x ./init_ssh.sh
./init_ssh.sh

docker-compose exec --user admin admin-host bash
cd /home/admin/ansible
ansible-playbook lemp-playbook.yml
ansible-playbook django-playbook.yml

docker-compose exec client-host-01 bash


http://client-host-02:8082/admin/