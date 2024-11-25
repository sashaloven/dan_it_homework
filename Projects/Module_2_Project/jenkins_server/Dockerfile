FROM jenkins/jenkins:latest
USER root

RUN usermod -u 1002 jenkins
RUN groupadd -g 972 docker
RUN groupmod -g 976 jenkins
RUN usermod -aG docker jenkins 

RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
    && echo "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list \
    && apt-get update \
    && apt-get install -y docker-ce docker-ce-cli containerd.io

RUN curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

#RUN usermod -u 1002 jenkins
#RUN groupmod -g 972 docker
#RUN usermod -aG docker jenkins

USER jenkins

