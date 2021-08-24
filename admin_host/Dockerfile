FROM ubuntu:20.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    ansible \
    nano \
    python3.8 \ 
    openssh-client \
    sudo \
    #remove cache:
    && rm -rf /var/lib/apt/lists/* 

RUN groupadd -g 1000 admin
RUN useradd -u 1000 -ms /bin/bash -g admin admin
USER admin
RUN ssh-keygen -q -t rsa -N '' -f /home/admin/.ssh/id_rsa

EXPOSE 7000