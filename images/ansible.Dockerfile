FROM ubuntu:18.04

RUN apt-get update; \
    apt install -y openssh-client; \
    apt install -y python3-pip; \
    apt install -y sshpass

RUN pip3 install "ansible==2.9.12"

RUN ansible-galaxy install geerlingguy.docker
RUN ansible-galaxy install geerlingguy.nginx
