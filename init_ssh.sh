#!/bin/bash

set -e

#docker-compose exec -T --user root admin_host bash -c "ssh-keygen -q -t rsa -N '' -f /home/admin/.ssh/id_rsa"
docker-compose exec -T --user root admin_host bash -c "cat /home/admin/.ssh/id_rsa.pub > /var/ssh_pub/id_rsa.pub \
    && chmod 400 /home/admin/.ssh/id_rsa*"
docker-compose exec -T client_host_01 bash -c "cat /var/ssh_pub/id_rsa.pub >> /home/client_host/.ssh/authorized_keys"
docker-compose exec -T client_host_02 bash -c "cat /var/ssh_pub/id_rsa.pub >> /home/client_host/.ssh/authorized_keys"
docker-compose exec -T client_host_03 bash -c "cat /var/ssh_pub/id_rsa.pub >> /home/client_host/.ssh/authorized_keys"

echo -e "\e[1;34m SSH configs has been created\e[0m"