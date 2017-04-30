FROM node:6.9.1

RUN apt-get -y -qq update && \
    apt-get -y -qq install \
        python-pip \
        python-dev \
        build-essential \
        postgresql-client \
        apt-transport-https \
        software-properties-common \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://download.docker.com/linux/debian/gpg |  apt-key add - && \
    add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/debian \
        $(lsb_release -cs) \
        stable" && \
    apt-get update && \
    apt-get -y -qq install docker-ce && \
    rm -rf /var/lib/apt/lists/*

RUN pip install awscli==1.11.81 credstash==1.11.0

RUN curl -o- -L https://yarnpkg.com/install.sh | bash -s -- --version 0.18.1

RUN wget --progress=dot:mega https://storage.googleapis.com/kubernetes-release/release/v1.4.6/bin/linux/amd64/kubectl && chmod +x kubectl && mv kubectl /usr/local/bin

# dockerie
ENV DOCKERIZE_VERSION="v0.3.0"
RUN wget --progress=dot:mega -O - https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz | tar -C /usr/local/bin -zx

ADD circle.npmrc /root/.npmrc
