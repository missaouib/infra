# Infra

## Start containers

`docker-compose up -d --remove-orphans`

## Nexus

- username: admin
- password: ` docker-compose exec nexus cat /nexus-data/admin.password`

### Nexus-pypi

- create nexus python-proxy with url(https://pypi.org)
- create nexus python-hosted
- create nexus python
- install twine: ```pip3 install twine```
- upload your lib: ```twine upload --repository-url=http://localhost:1000/repository/python-hosted/ name_lib.tar.gz```

### Nexus-npm

- create nexus npm-proxy with url(https://pypi.org)
- create nexus npm-hosted
- create nexus npm -```npm config set registry http://localhost:1000/repository/npm/```
  -```npm login --registry=http://localhost:1000/repository/npm/```
  -```npm publish {{packageName}}```

## Jenkins

- Unlock Jenkins with this command `docker-compose exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword`

## Sonar

- username: admin
- password: admin

## Stop/Down containers

- `docker-compose stop `
- `docker-compose down `

## Ansible (Server installation) [In progress]

- Copy ssh key `ssh-copy-id -i ~/.ssg/id_rsa.pub user@ip-server`  don't forget to change user and ip-server and if you
  use root user enable root login over ssh PermitRootLogin yes
- Enable root login over ssh
  `vim sshd_config` add `PermitRootLogin yes` `service sshd restart`
- Rename `hosts.example` to `hosts`
- Replace `0.0.0.0` with ip-server
- Check file variables ```roles/vars.yml```
- Playbook is in ```roles/servers.yml```
- ```cd ansible```
- Run this command
  ```ansible-playbook -i hosts roles/servers.yml --ssh-common-args='-o StrictHostKeyChecking=no'```
  OR
  ``` sh install_server.sh```

## Ansible (Server installation) With Docker [In progress] {Centos/Ubuntu/Debian}

- Install python3 in Centos Servers
  ```yum install -y python3```
- Build image
  ```docker build -f ansible.Dockerfile -t ansible:latest .```
- Rename `hosts.example` to `hosts`
- Replace `0.0.0.0` with your servers ip
- Run ansible with volume container and install playbook
  ```docker run -it --rm -v "$(pwd)/ansible":/ansible -v $HOME/.ssh/:/root/.ssh/ -w /ansible ckechad/ansible sh install_server.sh```

## Lunch only one service

### Nexus

- up `docker-compose -f nexus.docker-compose.yml up -d`
- down `docker-compose -f nexus.docker-compose.yml down`
- Open in browser [Nexus](http://localhost:1000/)

### Jenkins with docker

- up `docker-compose -f jenkins.docker-compose.yml up -d`
- down `docker-compose -f jenkins.docker-compose.yml down`
- Open in browser [Jenkins](http://localhost:1001/)

### Docker Registry

- up `docker-compose -f registry.docker-compose.yml up -d`
- down `docker-compose -f registry.docker-compose.yml down`
- Open in browser [Registry](http://localhost:1004/)

### Sonar

- up `docker-compose -f sonar.docker-compose.yml up -d`
- down `docker-compose -f sonar.docker-compose.yml down`
- Open in browser [Sonar](http://localhost:1005/)

### Confluence

- up `docker-compose -f confluence.docker-compose.yml up -d`
- down `docker-compose -f confluence.docker-compose.yml down`
- Open in browser [Confluence](http://localhost:8090/)

### Jira

- up `docker-compose -f jira.docker-compose.yml up -d`
- down `docker-compose -f jira.docker-compose.yml down`
- Open in browser [Jira](http://localhost:8080/)

## Images Docker Hub
### Node
- build image `docker build -f images/node.Dockerfile . -t ckechad/node:lts-stretch-slim`
- push image `docker push ckechad/node:lts-stretch-slim`
### Python
- build image `docker build -f images/python.Dockerfile . -t ckechad/python:3.9.4-slim`
- push image `docker push ckechad/python:3.9.4-slim`

## Jira / Confluence Production 
- Install docker and docker-compose in server with ansible
- `git clone https://github.com/ckec/infra.git`
- `cd infra/`
- `cp traefik/attlassian.traefik.yml.example traefik/traefik.yml`
- change domaine name in traefik/traefik.yml with your domaine 
- `docker-compose -f atlassian.prod.docker-compose.yml build`
- `docker-compose -f atlassian.prod.docker-compose.yml up -d`

## Jenkins Production 
- Install docker and docker-compose in server with ansible
- `git clone https://github.com/ckec/infra.git`
- `cd infra/`
- `cp traefik/jenkins.traefik.yml.example traefik/traefik.yml`
- change domaine name in traefik/traefik.yml with your domaine 
- `docker-compose -f jenkins.prod.docker-compose.yml build`
- `docker-compose -f jenkins.prod.docker-compose.yml up -d`

## Sonar / Nexus Production 
- Install docker and docker-compose in server with ansible
- `git clone https://github.com/ckec/infra.git`
- `cd infra/`
- `cp traefik/sonar-nexus.traefik.yml.example traefik/traefik.yml`
- change domaine name in traefik/traefik.yml with your domaine 
- `docker-compose -f sonar-nexus.prod.docker-compose.yml build`
- `docker-compose -f sonar-nexus.prod.docker-compose.yml up -d`