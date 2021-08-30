FROM ubuntu:20.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    openssh-server \
    nano \
    python3 \ 
    sudo \
    #remove cache:
    && rm -rf /var/lib/apt/lists/* 

RUN useradd -m client_host && echo "client_host:client_host" | chpasswd && adduser client_host sudo \
&& echo "client_host  ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/client_host
USER client_host
RUN ssh-keygen -q -t rsa -N '' -f /home/client_host/.ssh/id_rsa

EXPOSE 22
USER root
RUN /etc/init.d/ssh start

CMD ["/usr/sbin/sshd", "-D"]