# Copyright (c) 1998 - 2019 Wisers Information Limited. All rights reserved.

ARG REGISTRY_HOST=test.svoltems.cn:5000
ARG IMAGE_CATEGORY=svolt
ARG IMAGE_NAME=svolt-py3-base
ARG IMAGE_TAG=latest

FROM ${REGISTRY_HOST}/${IMAGE_CATEGORY}/${IMAGE_NAME}:${IMAGE_TAG}
MAINTAINER Svolt ESS Bussiness Middleware Architect Team "romeovan@163.com"

#COPY . .
# install python packages
#RUN pip install -r requirements.txt


# install SonarScanner 4.0
RUN mkdir /opt/sonarscanner && \
    cd /opt/sonarscanner && \
    wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.0.0.1744-linux.zip && \
    unzip sonar-scanner-cli-4.0.0.1744-linux.zip -d /opt/sonarscanner && \
    rm sonar-scanner-cli-4.0.0.1744-linux.zip && \
    chmod +x /opt/sonarscanner/sonar-scanner-4.0.0.1744-linux/bin/sonar-scanner && \
    ln -s /opt/sonarscanner/sonar-scanner-4.0.0.1744-linux/bin/sonar-scanner /usr/local/bin/sonar-scanner

# install docker
RUN apt update && \
    apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io
#    apt list -a docker-ce && \
#    systemctl status docker && \
#    usermod -aG docker $USER && \
#    docker info

# install docker-compose
RUN curl -L https://github.com/docker/compose/releases/download/1.23.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose && \
    docker-compose --version
