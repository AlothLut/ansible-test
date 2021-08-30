#!/bin/bash

set -e
#set -x

if [ "$EUID" -ne 0 ];  then
    echo "Not running as root"
    exit
fi

if [ -f ./ssh_pub/id_rsa.pub ]; then
    echo -e "\e[1;34m Removing a ssh-key from a previous session \e[0m"
    sudo rm ./ssh_pub/id_rsa.pub
fi

echo -e "\e[1;34m Set default login/pass for databeses from ./.env-example ([Y/n])?\e[0m"
read is_example_env
is_example_env=${is_example_env,,} # tolower
if [[ $is_example_env =~ ^(yes|y| ) ]] || [[ -z $is_example_env ]]; then
    cp -rp ./.env-example ./.env # copy with owner premissions
fi

echo -e "\e[1;34m Build containers \e[0m"
sudo docker-compose up -d --build

until docker ps | grep "client_host*"; do
    echo "w8 client hosts..."
    sleep 3;
done

docker-compose exec -T --user root admin_host bash -c "cat /home/admin/.ssh/id_rsa.pub > /var/ssh_pub/id_rsa.pub \
    && chmod 400 /home/admin/.ssh/id_rsa*"
docker-compose exec -T client_host_01 bash -c "cat /var/ssh_pub/id_rsa.pub >> /home/client_host/.ssh/authorized_keys"
docker-compose exec -T client_host_02 bash -c "cat /var/ssh_pub/id_rsa.pub >> /home/client_host/.ssh/authorized_keys"
docker-compose exec -T client_host_03 bash -c "cat /var/ssh_pub/id_rsa.pub >> /home/client_host/.ssh/authorized_keys"

echo -e "\e[1;34m SSH configs has been created\e[0m"

docker-compose exec -T --user admin admin_host bash -c "ansible-galaxy collection install community.mysql"

echo -e "\e[1;34m Additional ansible-modules installed\e[0m"


echo -e "\e[1;34m Add to /etc/hosts new rules\e[0m"

for i in {1..3}
do
   sudo grep -qxF "172.16.1.1 client_host_0$i" /etc/hosts || echo "172.16.1.1 client_host_0$i" | sudo tee -a /etc/hosts
done