docker-compose up -d
chmod +x ./init_ssh.sh
./init_ssh.sh

docker-compose exec --user admin admin_host bash
cd /home/admin/ansible
ansible all -m ping