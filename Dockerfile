FROM circleci/node:8.1.2

RUN sudo apt-get -y -qq update && \
    sudo apt-get -y -qq install \
        python-pip \
        python-dev \
        build-essential \
        postgresql-client \
        mysql-client \
        apt-transport-https \
        software-properties-common \
        jq \
    && sudo rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://download.docker.com/linux/debian/gpg |  sudo apt-key add - && \
    sudo add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/debian \
        $(lsb_release -cs) \
        stable" && \
    sudo apt-get update && \
    sudo apt-get -y -qq install docker-ce && \
    sudo rm -rf /var/lib/apt/lists/*

RUN sudo pip install awscli==1.11.81 credstash==1.11.0

RUN sudo wget --progress=dot:mega https://storage.googleapis.com/kubernetes-release/release/v1.6.2/bin/linux/amd64/kubectl && sudo chmod +x kubectl && sudo mv kubectl /usr/local/bin

# RUN curl -o- -L https://yarnpkg.com/install.sh | bash -s -- --version 0.23.4
RUN sudo npm install -g yarn@0.18.1

# dockerie
ENV DOCKERIZE_VERSION="v0.3.0"
RUN sudo wget --progress=dot:mega -O - https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz | sudo tar -C /usr/local/bin -zx

ADD circle.npmrc /home/circleci/.npmrc
ADD circle.npmrc /usr/local/share/.npmrc

ENV AWS_DEFAULT_REGION="us-west-2"
ENV PGHOST="localhost"
ENV PGUSER="ubuntu"
ENV BASH_ENV="/app/bash.env"

# use staging snowflake schema by default for build image
ENV USE_STAGING="true"

RUN sudo mkdir /app && sudo chown circleci:circleci app