FROM node:6.9.1

RUN apt-get -y -qq update && \
    apt-get -y -qq install \
        python-pip \
        python-dev \
        build-essential \
        postgresql-client \
    && rm -rf /var/lib/apt/lists/*

RUN pip install awscli==1.11.81 credstash==1.11.0

RUN curl -o- -L https://yarnpkg.com/install.sh | bash -s -- --version 0.18.1
RUN curl -s -S -O https://storage.googleapis.com/kubernetes-release/release/v1.4.6/bin/linux/amd64/kubectl && chmod +x kubectl

# dockerie
ENV DOCKERIZE_VERSION="v0.3.0"
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

ADD circle.npmrc /root/.npmrc

ENV PATH="${HOME}/.yarn/bin:${PATH}"
