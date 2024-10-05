FROM jenkins/inbound-agent

USER root

RUN usermod -u 1002 jenkins
RUN groupmod -g 976 jenkins
RUN groupadd -g 972 docker
RUN usermod -aG docker jenkins
RUN chown jenkins:docker  /home/jenkins
RUN chmod -R 755 /home/jenkins
RUN chown -R jenkins:jenkins /home/jenkins

RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    git && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN node -v && npm -v
USER jenkins


