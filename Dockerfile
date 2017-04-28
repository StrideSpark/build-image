FROM node:6.9.1

RUN apt-get -y -qq update && \
    apt-get -y -qq install \
        python-pip \
        python-dev \
        build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN pip install awscli==1.11.81 credstash==1.11.0

RUN curl -o- -L https://yarnpkg.com/install.sh | bash -s -- --version 0.18.1
RUN curl -s -S -O https://storage.googleapis.com/kubernetes-release/release/v1.4.6/bin/linux/amd64/kubectl && chmod +x kubectl

ADD circle.npmrc /root/.npmrc

ENV PATH="${HOME}/.yarn/bin:${PATH}"
