FROM ubuntu:20.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    openssh-server \
    nano \
    sudo

RUN groupadd -g 1000 client_host
RUN useradd -u 1000 -ms /bin/bash -g client_host client_host
USER client_host
RUN ssh-keygen -q -t rsa -N '' -f /home/client_host/.ssh/id_rsa

USER root
RUN service ssh start
EXPOSE 22

CMD ["/usr/sbin/sshd","-D"]