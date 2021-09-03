# Ansible tests
Despite the fact that philosophy docker its 1 process = 1 container,
this project was created for testing ansible playbooks.

## Dependencies:

##### docker, docker-compose

##### Tested on Ubuntu 20.1

## To run, execute sequentially:
```
chmod +x ./init_ssh.sh
./init_ssh.sh
```

```
docker-compose exec --user admin admin-host bash
cd /home/admin/ansible
ansible-playbook lemp-playbook.yml
ansible-playbook django-playbook.yml
```

## LEMP:

- http://client-host-01:8081/
- http://client-host-03:8083/

## DJANGO:

- http://client-host-02:8082/admin/